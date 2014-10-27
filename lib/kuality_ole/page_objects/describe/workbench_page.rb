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

class WorkbenchPage < KradPage

  page_url "#{KualityOle.url}portal.do?channelTitle=Search Workbench&channelUrl=#{KualityOle.url}ole-kr-krad/olesearchcontroller?viewId=OLESearchView&methodToCall=start"
 
  # -- Search Controls --
  element(:document_type)                               {|b| b.iframeportlet.select_list(:id => 'DocumentAndSearchSelectionType_DocType_control')}
  element(:search_type)                                 {|b| b.iframeportlet.select_list(:id => 'DocumentAndSearchSelectionType_SearchType_control')}
  action(:search)                                       {|b| b.iframeportlet.button(:id => 'SearchButton').when_present.click ; b.wait_until_loaded}
  action(:clear)                                        {|b| b.iframeportlet.button(:id => 'ClearButton').when_present.click ; b.wait_until_loaded}
  action(:new_search)                                   {|b| b.iframeportlet.button(:id => 'StartSearchButton').when_present.click ; b.wait_until_loaded }
  action(:export_xml)                                   {|b| b.iframeportlet.button(:id => 'exportToXml').when_present.click}
  action(:next)                                         {|b| b.iframeportlet.a(:text => /[Nn]ext/).when_present.click}
  action(:previous)                                     {|b| b.iframeportlet.a(:text => /[Pp]revious/).when_present.click}

  # -- Search Lines --
  element(:search_for)                                  {|i=0,b| b.iframeportlet.text_field(:id => "SearchConditions_SearchText_id_line#{i}_control")}
  element(:search_conditions)                           {|i=0,b| b.iframeportlet.select_list(:id => "SearchConditions_Operator_id_line#{i}_control")}
  element(:search_in_field)                             {|i=0,b| b.iframeportlet.select_list(:id => "SearchConditions_DocField_id_line#{i}_control")}
  action(:join_and)                                     {|i=0,b| b.iframeportlet.radio(:id => "SearchConditions_SearchScope_id_line#{i}_control_0").click}
  action(:join_or)                                      {|i=0,b| b.iframeportlet.radio(:id => "SearchConditions_SearchScope_id_line#{i}_control_1").click}
  action(:join_not)                                     {|i=0,b| b.iframeportlet.radio(:id => "SearchConditions_SearchScope_id_line#{i}_control_2").click}
  action(:add_line)                                     {|i=0,b| b.iframeportlet.button(:id => "addLineField-Add_line#{i}").when_present.click ; b.wait_until_loaded}
  action(:delete_line)                                  {|i=1,b| b.iframeportlet.button(:id => "deleteLineField-Delete_line#{i}").when_present.click ; b.wait_until_loaded}

  # -- Search Results --
  element(:results)                                     {|b| b.iframeportlet.div(:id => 'SearchFieldResultSection')}
  element(:text_in_results)                             {|which,b| b.iframeportlet.span(:class => 'uif-readOnlyContent',:text => /#{which}/)}
  value(:text_in_results?)                              {|which,b| b.text_in_results(which).present?}
  element(:link_in_results)                             {|which,b| b.iframeportlet.div(:class => 'uif-linkField').a(:text => /#{which}/) }
  value(:link_in_results?)                              {|which,b| b.link_in_results(which).present?}
  element(:any_in_results)                              {|which,b| if b.text_in_results?(which)
                                                                      b.text_in_results(which)
                                                                   elsif b.link_in_results?(which)
                                                                      b.link_in_results(which)
                                                                   else
                                                                      false
                                                                   end
                                                        }
  value(:any_in_results?)                               {|which,b| b.any_in_results?(which) ? true : false }


end
