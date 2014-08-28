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

module Watir
  class Select
    alias_method(:orig_select_by,:select_by)

    # Extend Select #select_by to wait for a value to be present before selecting it.
    #
    #   This is sometimes necessary in OLE, especially, for example, on the Describe Workbench:
    #   selecting a new document search type will cause a delay in the search field selector
    #   values' appearance as they reset (apparently one-by-one) after the page has loaded.
    #
    def select_by(how,str_or_rx)
      assert_exists
      Wait.until(Watir.default_timeout,"waiting for option with #{how} \'#{str_or_rx}\'") {include?(str_or_rx)}
      orig_select_by(how,str_or_rx)
    end

    # Fit nicely whether we're dealing with an option's text or its value.
    def fit(str_or_rx)
      if include?(str_or_rx)
        select_by(:text,str_or_rx) unless str_or_rx.nil?
      else
        select_by(:value,str_or_rx) unless str_or_rx.nil?
      end
    end

    # Returns the text of all selected options.
    def get_selected_text
      get_selected(:text)
    end

    # Returns the values of all selected options.
    def get_selected_value
      get_selected(:value)
    end

    private
    # Returns an array of attributes on all selected options.
    def get_selected(how)
      when_present.selected_options.collect {|this| this.send(how)}
    end
  end

  class TextField
    # Enter a text value followed by a newline character.
    # @note Intended for fields which work with input devices.
    def enter(which)
      set "#{which}\n"
    end
  end
end