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

  # Define blocks of elements to instantiate via method call on a page definition.
  class << self

    # Define the portal tabs if they are visible on a given page.
    def portal_tabs
      element(:deliver_tab)            {|b| b.div(:id => 'tabs').ul.li.a(:title => 'Deliver')}
      element(:describe_tab)           {|b| b.div(:id => 'tabs').ul.li.a(:title => 'Describe')}
      element(:deliver_tab)            {|b| b.div(:id => 'tabs').ul.li.a(:title => 'Select/Acquire')}
      element(:maintenance_tab)        {|b| b.div(:id => 'tabs').ul.li.a(:title => 'Maintenance')}
      element(:admin_tab)              {|b| b.div(:id => 'tabs').ul.li.a(:title => 'Admin')}
    end

    # Call this method on a page to create frame elements.
    def uses_frames
      element(:iframeportlet)                       {|b| b.iframe(:id => 'iframeportlet')}
    end
  end
end
