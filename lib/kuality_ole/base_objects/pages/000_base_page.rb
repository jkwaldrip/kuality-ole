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

# Base Page Class
class BasePage < PageFactory

  # The OLE build tag (upper right-hand corner of every OLE screen.
  value(:build_info)                    {|b| b.div(:id => 'build').text}

  # -- Portal Tabs --
  # @note Visible on all except DocStore interface pages.
  element(:deliver_tab)             {|b| b.div(:id => 'tabs').a(:title => 'Deliver')}
  element(:describe_tab)            {|b| b.div(:id => 'tabs').a(:title => 'Describe')}
  element(:select_acquire_tab)      {|b| b.div(:id => 'tabs').a(:title => 'Select/Acquire')}
  element(:maintenance_tab)         {|b| b.div(:id => 'tabs').a(:title => 'Maintenance')}
  element(:admin_tab)               {|b| b.div(:id => 'tabs').a(:title => 'Admin')}

  # -- Portal Links --
  action(:action_list)              {|b| b.a(:class => 'portal_link',:title => 'Action List').when_present.click}
  action(:doc_search)               {|b| b.a(:class => 'portal_link',:title => 'Document Search').when_present.click }
  action(:workbench)                {|b| b.a(:class => 'portal_link',:title => 'Search Workbench').when_present.click }

  # Define blocks of elements to instantiate via method call on a page definition.
  class << self

    # Call this method on a page to create frame elements.
    def uses_frames
      element(:iframeportlet)                       {|b| b.iframe(:id => 'iframeportlet')}
    end

    # Return the current date in MM/DD/YYYY format.
    #   This is included here so that actions which require a date to be input
    #   may have a default value.
    def today
      KualityOle.today
    end

  end
end
