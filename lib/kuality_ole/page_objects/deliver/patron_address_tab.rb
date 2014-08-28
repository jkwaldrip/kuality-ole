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

class PatronAddressTab < KradPage
 
  line_element(:toggle_details)                   {|line|
                                                    line.new {|b| b.iframeportlet.a(:id => 'OlePatronDocument-Address_detLink_add').when_present.click}
                                                    line.added {|i = 0,b| b.iframeportlet.a(:id => "OlePatronDocument-Address_detLink_line#{i}").when_present.click}
                                                  }
  line_element(:type)                             {|line|
                                                    line.new {|b| b.iframeportlet.select_list(:id => 'addressTypeCode_add_control')}
                                                    line.added {|i = 0,b| b.iframeportlet.select_list(:id => "addressTypeCode_line#{i}_control")}
                                                  }
  line_element(:source)                           {|line| 
                                                    line.new {|b| b.iframeportlet.select_list(:id => 'addressSource_add_control')}
                                                    line.added {|i = 0,b| b.iframeportlet.select_list(:id => "addressSource_line#{i}_control")}
                                                  }
                                                 
  line_element(:valid_from)                       {|line|
                                                    line.new {|b| b.iframeportlet.text_field(:id => 'addressValidFrom_add_control')}
                                                    line.added {|i = 0,b| b.iframeportlet.text_field(:id => "addressValidFrom_line#{i}_control")}
                                                  }
  line_element(:valid_to)                         {|line|
                                                    line.new {|b| b.iframeportlet.text_field(:id => 'addressValidTo_add_control')}
                                                    line.added {|i = 0,b| b.iframeportlet.text_field(:id => "addressValidTo_line#{which}_control")}
                                                  }
  line_element(:verified)                         {|line|
                                                    line.new {|b| b.iframeportlet.checkbox(:id => 'addressVerified_add_control')}
                                                    line.added {|i = 0,b|  b.iframeportlet.checkbox(:id => "addressVerified_line#{i}_control")}
                                                  }
  line_element(:preferred)                        {|line|
                                                    line.new {|b| b.iframeportlet.checkbox(:id => 'defaultValue_add_control')}
                                                    line.added {|i = 0,b| b.iframeportlet.checkbox(:id => "defaultValue_line#{i}_control")}
                                                  }
  line_element(:active)                           {|line|
                                                    line.new {|b| b.iframeportlet.checkbox(:id => 'active_add_control')}
                                                    line.added {|i = 0,b| b.iframeportlet.checkbox(:id => "active_line#{i}_control")}
                                                  }
  line_element(:line_1)                           {|line|
                                                    line.new {|b| b.iframeportlet.text_field(:id => 'line1_add_control')}
                                                    line.added {|i = 0,b| b.iframeportlet.text_field(:id => "line1_line#{i}_control")}
                                                  }
  line_element(:line_2)                           {|line|
                                                    line.new {|b| b.iframeportlet.text_field(:id => 'line2_add_control')}
                                                    line.added {|i = 0,b| b.iframeportlet.text_field(:id => "line2_line#{i}_control")}
                                                  }
  line_element(:line_3)                           {|line|
                                                    line.new {|b| b.iframeportlet.text_field(:id => 'line3_add_control')}
                                                    line.added {|i = 0,b| b.iframeportlet.text_field(:id => "line3_line#{i}_control")}
                                                  }
  line_element(:city)                             {|line|
                                                    line.new {|b| b.iframeportlet.text_field(:id => 'city_add_control')}
                                                    line.added {|i = 0,b| b.iframeportlet.text_field(:id => "city_line#{i}_control")}
                                                  }
  line_element(:state)                            {|line|
                                                    line.new {|b| b.iframeportlet.select_list(:id => 'state_add_control')}
                                                    line.added {|i = 0,b| b.iframeportlet.select_list(:id => "state_line#{i}_control")}
                                                  }
  line_element(:postal_code)                      {|line|
                                                    line.new {|b| b.iframeportlet.text_field(:id => 'postalCode_add_control')}
                                                    line.added {|i = 0,b| b.iframeportlet.text_field(:id => "postalCode_line#{i}_control")}
                                                  }
  line_element(:country)                          {|line|
                                                    line.new {|b| b.iframeportlet.select_list(:id => 'country_add_control')}
                                                    line.added {|i = 0,b| b.iframeportlet.select_list(:id => "country_line#{i}_control")}
                                                  }
  line_value(:expanded?)                          {|line|
                                                    line.new {|b| b.line_1(:new).present?}
                                                    line.added {|i = 0,b| b.line_1(:added,i).present?}
                                                  }
  action(:add)                                    {|b| b.iframeportlet.button(:id => 'OlePatronDocument-Address_add').when_present.click}
  action(:delete)                                 {|i = 0,b| b.iframeportlet.button(:id => "OlePatronDocument-Address-delete_line#{i}").when_present.click}

end
