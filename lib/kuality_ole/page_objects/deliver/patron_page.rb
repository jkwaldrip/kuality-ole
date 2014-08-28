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

class PatronPage < KradEdocPage

  # -- Patron Overview --
  # @note Patron ID is blank on a new patron record.
  value(:id)                                      {|b| b.iframeportlet.td.div(:data_label => 'Patron Id').span(:class => 'uif-readOnlyContent')}
  element(:barcode)                               {|b| b.iframeportlet.text_field(:id => 'barcode_control')}
  element(:type)                                  {|b| b.iframeportlet.select_list(:id => 'borrowerType_control')}
  element(:source)                                {|b| b.iframeportlet.select_list(:id => 'sourceType_control')}
  element(:image)                                 {|b| b.iframeportlet.file_field(:id => 'attachment_Files_control').to_subtype}
  element(:upload_image_button)                   {|b| b.iframeportlet.button(:id => 'uploadButton_patron')}
  action(:upload_image)                           {|which,b| b.image_field.set(which) ; b.upload_image_button.when_present.click }
  element(:statistical_category)                  {|b| b.iframeportlet.select_list(:id => 'statisticalCategory_control')}
  element(:activation_date)                       {|b| b.iframeportlet.text_field(:id => 'activationDate_control')}
  element(:expiration_date)                       {|b| b.iframeportlet.text_field(:id => 'expirationDate_control')}
  element(:active)                                {|b| b.iframeportlet.checkbox(:id => 'activeIndicator_control')}
  value(:active?)                                 {|b| b.active_checkbox.when_present.set?}
  action(:activate)                               {|which_date = today,b| b.active_checkbox.set unless b.active?
                                                    b.activation_date_field.when_present.set(which_date)
                                                    [] << b.active? << b.activation_date
                                                    # On success => [true, "MM/DD/YYYY"]
                                                  }
  action(:expire)                                 {|which_date = today,b| b.active_checkbox.click if b.active?
                                                    b.expiration_date_field.when_present.set(which_date)
                                                    [] << b.active? << b.expiration_date
                                                   # On success => [false, "MM/DD/YYYY"]
                                                  }

  # -- Contacts --
  # -- Patron Name --
  value(:name_type)                               {|b| b.iframeportlet.span(:id => 'nameType_control')}
  element(:patron_title)                          {|b| b.iframeportlet.select_list(:id => 'namePrefix_control')}
  element(:first_name)                            {|b| b.iframeportlet.text_field(:id => 'firstName_control')}
  element(:middle_name)                           {|b| b.iframeportlet.text_field(:id => 'middleName_control')}
  element(:last_name)                             {|b| b.iframeportlet.text_field(:id => 'lastName_control')}
  element(:suffix)                                {|b| b.iframeportlet.select_list(:id => 'nameSuffix_control')}

  # -- Tabs --
  action(:toggle_overview)                        {|b| b.iframeportlet.a(:id => 'OlePatronDocument-OverviewSection_toggle')}
  action(:toggle_contacts)                        {|b| b.iframeportlet.a(:id => 'OlePatronDocument-ContactsSection_toggle').when_present.click}

  # -- Contacts Tab --
  action(:toggle_name)                            {|b| b.iframeportlet.a(:id => 'OlePatronDocument-Name_toggle').when_present.click}
  action(:toggle_address)                         {|b| b.iframeportlet.a(:id => 'OlePatronDocument-Address_toggle').when_present.click}
  action(:toggle_phone)                           {|b| b.iframeportlet.a(:id => 'OlePatronDocument-Phone_toggle')}
  action(:toggle_email)                           {|b| b.iframeportlet.a(:id => 'OlePatronDocument-Email_toggle')}

  # TODO Affiliation, Library Policies, Loaned Records, Requested Records, Temporary Circulation History records, Note, Proxy Patron, Proxy For, Local Identification, Ad Hoc Recipients, Route Log
end
