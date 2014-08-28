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

class LoanPage < CirculationPage

  # -- Main --
  action(:close)                        {|b| b.iframeportlet.button(:id => 'doneButton').when_present.click }

  # -- Circulation --
  element(:patron_barcode)              {|b| b.iframeportlet.text_field(:id => 'Patron-barcode_control')}
  action(:patron_search)                {|b| b.iframeportlet.fieldset(:id => 'Patron-barcode_fieldset').input(:index => 1,:class => 'uif-actionImage').when_present.click}
  element(:item_barcode)                {|b| b.iframeportlet.text_field(:id => 'Patron-item_control')}
  action(:item_search)                  {|b| b.iframeportlet.fieldset(:id => 'Patron-item_fieldset').input(:index => 1,:class => 'uif-actionImage').when_present.click}
  action(:fast_add_item)                {|b| b.iframeportlet.button(:id => 'FastAddItemSectionLink')}
  action(:renew)                        {|b| b.iframeportlet.button(:id => 'renewalButton').when_present.click ; b.wait_til_loaded}

  # -- Loan Popup --
  element(:loan_popup)                  {|b| b.iframeportlet.div(:id => "MessagePopupSection")}
  value(:loan_popup?)                   {|b| b.loan_popup.present?}
  element(:due_date)                    {|b| b.loan_popup.text_field(:id => 'popUpDate_control')}
  element(:due_time)                    {|b| b.loan_popup.text_field(:id => 'popUpTime_control')}
  action(:confirm_loan)                 {|b| b.loan_popup.button(:id => 'loanBtn').when_present.click ; b.wait_until_loaded}
  action(:deny_loan)                    {|b| b.loan_popup.button(:id => 'noLoanBtn').when_present.click ; b.wait_until_loaded}

  # -- Patron --
  action(:toggle_patron_details)        {|b| b.iframeportlet.a(:id => 'PatronDetailList-HorizontalBoxSection_toggle').when_present.click ; b.wait_until_loaded}
  action(:clear_patron)                 {|b| b.iframeportlet.button(:id => 'clearPatronButton').when_present.click ; b.wait_until_loaded}
  value(:patron_name)                   {|b| b.iframeportlet.div(:id => 'patronName').a.when_present.text.strip}
  value(:patron_type)                   {|b| b.iframeportlet.span(:id => 'patronType_control').when_present.text.strip}
  # NOTE:  preferred value shown
  value(:patron_address)                {|b| b.iframeportlet.span(:id => 'patronPreferredAddress_control').when_present.text.strip}
  value(:patron_phone)                  {|b| b.iframeportlet.span(:id => 'patronPhone_control').when_present.text.strip}
  value(:patron_email)                  {|b| b.iframeportlet.span(:id => 'patronEmail_control').when_present.text.strip}

  # -- Items --
  element(:checked_out_items)           {|b| b.iframeportlet.div(:id => 'Patron-LoanItemListSection-HorizontalBoxSection')}
  value(:checked_out_items?)            {|b| b.checked_out_items.present?}
  action(:toggle_checked_out_items)     {|b| b.checked_out_items.a(:id => 'Patron-LoanItemListSection-HorizontalBoxSection_toggle').when_present.click ; b.wait_until_loaded}
    # Text matching must be performed by Regex due to whitespace padding.
  element(:barcode_in_items)            {|txt,b| b.checked_out_items.table(:class => 'dataTable').a(:class => 'uif-link',:text => /#{txt}/i)}
  value(:barcode_in_items?)             {|txt,b| b.barcode_in_items(txt).present?}
  element(:text_in_items)               {|txt,b| b.checked_out_items.table(:class => 'dataTable').span(:class => 'uif-readOnlyContent',:text => /#{txt}/i)}
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

  # -- Messages --
  value(:loan_messages)                 {|b| b.iframeportlet.div(:id => 'LoanMessageFieldSection').spans(:class => 'uif-message').when_present.collect {|msg| msg.text.strip}}

end
