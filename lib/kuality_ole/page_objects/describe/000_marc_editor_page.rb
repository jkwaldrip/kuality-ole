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

# The base class for the MarcEditor.
#   (Contains methods used by Marc Bib Editor, Holdings Editor, & Item Editor)
class MarcEditorPage < KradPage

  page_url "#{KualityOle.url}portal.do?channelTitle=Marc Editor&channelUrl=#{KualityOle.url}ole-kr-krad/editorcontroller?viewId=EditorView&methodToCall=load&docCategory=work&docType=bibliographic&docFormat=marc&editable=true"

  # -- Buttons --
  element(:submit_button)                       {|b| b.iframeportlet.button(:id => "submitEditor")}
  element(:cancel_button)                       {|b| b.iframeportlet.button(:id => "cancelEditor")}
  element(:close_button)                        {|b| b.iframeportlet.button(:id => "closeEditor")}
  element(:return_to_search_button)             {|b| b.iframeportlet.button(:id => "returnToSearch_button")}

  # -- Navigation Area Elements --
  action(:delete_bib)                           {|b| b.iframeportlet.button(:title => 'Delete Bib').when_present.click}
  action(:add_instance)                         {|b| b.iframeportlet.button(:title => 'Add Instance').when_present.click}
  element(:add_einstance_button)                {|b| b.iframeportlet.button(:title => 'Add EInstance')}
  element(:holdings_tree)                       {|i,b| b.iframeportlet.div(:id => 'holdingsItemTree_tree').ul(:class => 'jstree-no-icons').li(:index => i)}
  element(:holdings_link)                       {|i,b| b.holdings_tree(i).a.span(:class => 'uif-message')}
  value(:holdings_expanded?)                    {|i,b| b.holdings_tree(i).attribute_value(:class).include?('jstree-open')}
  action(:expand_holdings)                      {|i,b| b.holdings_tree(i).ins(:class => 'jstree-icon').when_present.click unless b.holdings_expanded?(i)}
  element(:item_link)                           {|which_holdings,which_item,b| b.iframeportlet.div(:id => 'holdingsItemTree_tree').ul(:class => 'jstree-no-icons').li(:index => which_holdings).ul.li(:index => which_item).a}
  # @note Vakata Context Menu items are only present on the screen after the containing menu header has been right-clicked.
  #   This means that there will only ever be one of each on the screen at any given time.
  action(:delete_instance)                      {|b| b.iframeportlet.div(:id => 'vakata-contextmenu').ul.li(:index => 0).a(:rel => "Delete").when_present.click}
  action(:add_item)                             {|b| b.iframeportlet.button(:title => 'Add Item').when_present.click}
  action(:delete_item)                          {|b| b.iframeportlet.div(:id => 'vakata-contextmenu').ul.li(:index => 0).a(:rel => 'Delete').when_present.click}

  # -- Workflow Control --
  # Save the current record and return success message/s.
  action(:save)                                 {|b|
                                                  b.submit_button.when_present.click
                                                  b.message_list.wait_until_present
                                                  if b.error.present?
                                                    raise KualityOle::Error,"Save failed with the following errors:\n#{([b.message_header].push(*b.all_errors)).join("\n")}"
                                                  elsif b.message.present?
                                                    b.all_messages
                                                  else
                                                    raise KualityOle::Error,"Save failed, no messages nor errors given. (#{self.class.name})"
                                                  end
                                                }

end
