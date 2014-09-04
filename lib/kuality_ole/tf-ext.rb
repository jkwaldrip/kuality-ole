#  Copyright 2005-2014 The Kuali Foundation
#
#  Licensed under the Educational Community License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at:
#
#    http://www.opensource.org/licenses/ecl2.php
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

module Foundry

  # Allow pages to be loaded in frames with the .on call.
  def on(page_class, visit = false, in_frame = false, &block)
    $current_page = page_class.new(@browser, visit, in_frame)
    block.call $current_page if block
    $current_page
  end
  alias_method :on_page, :on

  # Redefine visit to automatically not load a page in a frame.
  # @note If a page is being opened by URL, it is not being loaded in a frame.
  #   The in_frame option is only used for pages being loaded inside of other pages.
  def visit(page_class, &block)
    on page_class, visit = true, in_frame = false, &block
  end

  # Open the given page class in a frame on whatever page is currently open.
  def in_frame(page_class, &block)
    on page_class, visit = false, in_frame = true, &block
  end
  alias_method(:on_page_in_frame,:in_frame)
end

class DataFactory

  # -- Line Collection Support
  def line(which)
    which += "Line" unless which =~ /Line$/
    Kernel.const_get(which).new(@browser)
  end

  # -- Page-Fill Methods --

  # Automagically fill out an array of elements on the given page from appropriate instance variables.
  #
  # @note Handles both regular and line elements, but requires an instance variable of the same name to exist.
  #   Will not check options hashes, as opts may have immature values (e.g., lookups not yet performed).
  #
  # Params:
  #   page          Object        The page object to use.
  #   data          Array         The array of elements to fill.
  #
  def autofill(page,data)
    data.each do |lmnt|
      val = instance_variable_get("@#{lmnt}")
      lmnt = page.send(lmnt)
      afill(lmnt,val)
    end
  end

  # Automagically fill out an ordered hash of elements on the given page from appropriate instance variables.
  #
  # @note Handles both regular and line elements, but requires an instance variable of the same name to exist.
  #   Will not check options hashes, as opts may have immature values (e.g., lookups not yet performed).
  #
  # Params:
  #   page          Object        The page object to use.
  #   data          Hash          A hash with element names (as on page) for keys,
  #                               and an array of arguments to pass to each element, action, or value.
  #
  def autofill_params(page,data)
    data.each do |lmnt,args|
      val = instance_variable_get("@#{lmnt}")
      lmnt = page.send(lmnt,*args)  # Send selection parameters now if they exist.
      afill(lmnt,val)
    end
  end

  private

  # A slower element setting method, to help us lose any races against OLE.
  def afill(lmnt,val)
    if lmnt.is_a?(Watir::Select)
      lmnt.pick!(val)
    else
      lmnt.when_present.fit(val)
    end
  end
end


class PageFactory

  # -- FRAME HANDLING --

  # Extend PageFactory so that it loads a page in a frame if requested.
  def initialize(browser, visit = false, in_frame = false)
    @browser = browser
    goto if visit
    load_in_frame if in_frame
    expected_element if respond_to? :expected_element
    has_expected_title? if respond_to? :has_expected_title?
  end

  # Load the page inside a Fancybox iframe.
  # @note Fancybox iframes are used for lightboxing
  #   page-inside-a-page views in OLE KRAD-based pages.
  def load_in_frame
    self.instance_eval do
      def method_missing(sym, *args, &block)
        @browser.iframe(:class => 'fancybox-iframe').send(sym, *args, &block)
      end
    end
  end
  alias_method(:load_in_iframe,:load_in_frame)

  # -- WAITING --

  # Wait for a page class to be fully loaded.
  #   This entails waiting for Ajax activity to stop
  #   as well as waiting for multiple elements to be present.
  #
  def wait_until_loaded
    wait_for_ajax Watir.default_timeout,"\n#{self.class.name}: wait until loaded."
    # wait_for.each {|lmnt| self.send(lmnt).wait_until_present } unless wait_for.nil?
    Watir::Wait.until {wait_for.each {|lmnt| self.send(lmnt).present?}} unless wait_for.nil?
    true
  end
  alias_method(:wait_till_loaded,:wait_until_loaded)

  class << self

    # Define a repeatable element in a linear arrangement of elements, such as a data line on the OLE Marc Bib Editor.
    #   A line element can be defined with multiple anticipated callbacks from usage.
    #   Each anticipated callback is defined as a block anticipating at least one argument,
    #   exactly the way a regular TestFactory element would.
    #   As with a normal TestFactory element, the last argument to be passed will always
    #   be self, where self is the page instance.
    #   The callback will be caught from whatever symbol is passed as the first argument when the element
    #   is called.
    #
    # Example:
    #
    # line_element(:foo)      {|line|
    #                          line.new {|b|  b.text_field(:id => 'new_editable_line')}
    #                          line.added {|i,b| b.text_field(:id => "editable_line#{i}")}
    #                          line.readonly {|i,b| b.span(:id => 'readonly_line#{i}"}
    #                         }
    #
    # action(:add_foo)        {|b| b.button(:id => 'add_new_line').when_present.click}
    #
    # Usage:
    #
    # on ExamplePage do |page|
    #   page.foo(:new).set('Hello, World!')
    #   page.add_foo
    #   page.foo(:added,0).when_present.value
    # end
    #
    # @note
    #   The method generated by line_element generally requires that a symbol be passed in as the first argument.
    #   The default behavior is to prepend :new if a symbol is not found when the method is called.
    #
    def line_element(name,&block)
      raise KualityOle::Error,"#{name} is defined twice in #{self}" if self.instance_methods.include?(name.to_sym)
      define_method name.to_s do |*args|
        # Default to passing :new to callback.
        if args.empty? || !args[0].is_a?(Symbol)
          args.unshift(:new)
        end
        callbacks = Callback.new(block)
        callbacks.callback(*args,self)
      end
    end
    alias_method(:line_action,:line_element)
    alias_method(:line_value,:line_element)

    # Wait on more than one element to consider the page loaded.
    #
    # Usage:
    #
    # class FooPage < KradEdocPage
    #   wait_on :some_header,:submit_button,:close_button
    #   . . .
    # end
    #
    # on FooPage do |page|
    #   page.click_a_button
    #   page.wait_until_loaded
    # end
    #
    def wait_on(*lmnts)
      @wait_for ||= []
      lmnts.each {|lmnt| @wait_for << lmnt}
    end
    attr_accessor :wait_for
  end

  private

  # A reader method for the class instance variable @wait_for.
  def wait_for
    self.class.wait_for
  end
  
end

class CollectionsFactory
  def self.contains klass
    # Opts hash is now optional.
    define_method 'add' do |opts={}|
      constituent = klass.new @browser,opts
      constituent.create
      self << constituent
    end

    # Add a constituent without invoking #create.
    define_method 'add_only' do |opts={}|
      constituent = klass.new @browser,opts
      self << constituent
    end
  end
end
# Re-aliasing
class CollectionFactory < CollectionsFactory ; end
