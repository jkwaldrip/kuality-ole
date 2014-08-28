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

class ReturnPage < CirculationPage

  # -- Main --
  action(:end_session)                  {|b| b.iframeportlet.button(:id => 'endSessionButton').when_present.click}

  # -- Circulation --
  element(:item_barcode)                {|b| b.iframeportlet.text_field(:id => 'CheckInItem_control')}
  element(:damaged_checkin)             {|b| b.iframeportlet.checkbox(:id => 'DamagedCheckIn_control')}
  element(:checkin_date)                {|b| b.iframeportlet.text_field(:id => 'CheckInDate_control')}
  element(:checkin_time)                {|b| b.iframeportlet.text_field(:id => 'CheckInTime_control')}

  # -- Return Popup --
  element(:return_popup)                {|b| b.iframeportlet.div(:id => 'MessagePopupSectionForReturn')}
  value(:return_popup?)                 {|b| b.return_popup.present?}
  action(:confirm_return)               {|b| b.return_popup.button(:id => 'returnBtn')}
  action(:deny_return)                  {|b| b.return_popup.button(:id => 'noReturnBtn')}

  # -- Items --
  element(:items_returned)              {|b| b.iframeportlet.div(:id => 'ItemReturnedList-HorizontalBoxSection')}
  value(:items_returned?)               {|b| b.items_returned.present?}
  # Text matching must be performed by Regex due to whitespace padding.
  element(:barcode_in_items)            {|txt,b| b.items_returned.table(:class => 'dataTable').a(:class => 'uif-link',:text => /#{txt}/i)}
  value(:barcode_in_items?)             {|txt,b| b.barcode_in_items(txt).present?}
  element(:text_in_items)               {|txt,b| b.items_returned.table(:class => 'dataTable').span(:class => 'uif-readOnlyContent',:text => /#{txt}/i)}
  value(:text_in_items?)                {|txt,b| b.text_in_items(txt).present?}
  element(:any_in_items)                {|txt,b| if b.barcode_in_items?(txt)
                                                    b.barcode_in_items(txt)
                                                  elsif b.text_in_items?(txt)
                                                    b.text_in_items(txt)
                                                  else
                                                    false
                                                  end
                                        }
  value(:any_in_items?)                 {|txt,b| b.any_in_items(txt) ? true : false }


end