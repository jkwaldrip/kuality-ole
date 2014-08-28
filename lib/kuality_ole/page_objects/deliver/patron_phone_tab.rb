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

class PatronPhoneTab < KradPage

  line_element(:type)                         {|line|
                                                line.new {|b| b.iframeportlet.select_list(:id => 'phoneTypeCode_add_control')}
                                                line.added {|i = 0,b| b.iframeportlet.select_list(:id => "phoneTypeCode_line#{i}_control")}
                                              }
  line_element(:number)                       {|line|
                                                line.new {|b| b.iframeportlet.text_field(:id => 'phoneNumber_add_control')}
                                                line.added {|i = 0,b| b.iframeportlet.text_field(:id => "phoneNumber_line#{i}_control")}
                                              }
  line_element(:extension)                    {|line|
                                                line.new {|b| b.iframeportlet.text_field(:id => 'extensionNumber_add_control')}
                                                line.added {|i = 0,b| b.iframeportlet.text_field(:id => "extensionNumber_line#{i}_control")}
                                              }
  line_element(:country)                      {|line|
                                                line.new {|b| b.iframeportlet.select_list(:id => 'countryCode_add_control')}
                                                line.added {|i = 0,b| b.iframeportlet.select_list(:id => "countryCode_line#{i}_control")}
                                              }
  line_element(:preferred)                    {|line|
                                                line.new {|b| b.iframeportlet.checkbox(:id => 'phoneNumber_defaultValue_add_control')}
                                                line.added {|i = 0,b| b.iframeportlet.checkbox(:id => "phoneNumber_defaultValue_line#{i}_control")}
                                              }
  line_element(:active)                       {|line|
                                                line.new {|b| b.iframeportlet.checkbox(:id => 'phoneNumber_active_add_control')}
                                                line.added {|i = 0,b| b.iframeportlet.checkbox(:id => "phoneNumber_active_line#{i}_control")}
                                              }
  action(:add)                                {|b| b.iframeportlet.button(:id => 'OlePatronDocument-Phone-Add_add').when_present.click}
  action(:delete)                             {|i = 0,b| b.iframeportlet.button(:id => "OlePatronDocument-Phone_del_line#{i}").when_present.click}
end