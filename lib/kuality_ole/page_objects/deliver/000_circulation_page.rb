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

class CirculationPage < KradPage

  # -- Circulation Desk --
  element(:circulation_desk)            {|b| b.iframeportlet.select_list(:name => 'circulationDesk')}
  # FIXME Make this element faster.
  element(:desk_change_popup)           {|b| b.iframeportlet.div(:class => 'uif-boxSubSection', :id => /Confirm(?:Return)?CirculationLocation-Change/)}
  value(:desk_change_popup?)            {|b| b.desk_change_popup.present?}
  action(:confirm_desk_change)          {|b| b.desk_change_popup.parent.button(:class => 'uif-smallActionButton',:id => /Change(?:Return)?CirculationLocationBtn/).when_present.click ; b.wait_until_loaded}
  action(:deny_desk_change)             {|b| b.desk_change_popup.parent.button(:class => 'uif-smallActionButton',:id => /(?:Return)?CirculationLocationCloseBtn/).when_present.click ; b.wait_until_loaded}

  # -- Page Controls --
  action(:return_page)                  {|b| b.iframeportlet.button(:id => 'ReturnLinkView-buttons').when_present.click}
  action(:loan_page)                    {|b| b.iframeportlet.button(:id => 'LoanScreenLinkView-buttons')}

end