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


class PageFactory
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

end
