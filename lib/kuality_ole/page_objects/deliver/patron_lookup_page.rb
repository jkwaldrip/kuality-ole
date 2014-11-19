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

# The Patron Lookup page in the OLE Library System.

class PatronLookupPage < KradPage

  # # -- Create New Patron --
  action(:create_new)             { |b| b.iframeportlet.link(:text => /[Cc]reate [Nn]ew/).when_present.click }

  # # Set Patron Lookup elements.
  element(:patron)                { |b| b.iframeportlet.text_field(:id => 'olePatronId_control') }
  element(:barcode)               { |b| b.iframeportlet.text_field(:id => 'barcode_control') }
  element(:first_name)            { |b| b.iframeportlet.text_field(:id => 'firstName_control') }
  element(:middle_name)           { |b| b.iframeportlet.text_field(:id => 'middleName_control') }
  element(:last_name)             { |b| b.iframeportlet.text_field(:id => 'lastName_control') }
  element(:patron_type)           { |b| b.iframeportlet.select_list(:id => 'borrowerType_control') }
  element(:email_address)         { |b| b.iframeportlet.text_field(:id => 'emailAddress_control') }

  # # Search Controls
  action(:active_yes)             { |b| b.iframeportlet.radio(:id => 'activeIndicator_control_0').click }
  action(:active_no)              { |b| b.iframeportlet.radio(:id => 'activeIndicator_control_1').click }
  action(:active_both)            { |b| b.iframeportlet.radio(:id => 'activeIndicator_control_2').click }
  action(:search)                 {|b| b.iframeportlet.button(:text => /search/i).when_present.click ; b.wait_until_loaded }
  action(:clear)                  {|b| b.iframeportlet.button(:text => /clear/i).when_present.click ; b.wait_until_loaded }
  action(:cancel)                 {|b| b.iframeportlet.button(:text => /cancel/i).when_present.click ; b.wait_until_loaded }

  # # -- Search Results --
  value(:results?)                { |b| b.iframeportlet.span(:id => /searchResult_olePatronId/).present? }

  element(:text_in_results)       { |which, b| b.iframeportlet.table(:class => 'dataTable').a(:text => /#{which}/) }
  value(:text_in_results?)        { |which, b| b.text_in_results(which).present? }

  element(:link_by_text)          {|txt,which,b| b.text_in_results(which).parent.parent.parent.td(:index => 0).a(:text => /#{txt}/)}


end

