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

  # -- Message Handling --
  element(:message_list)                        {|b| b.iframeportlet.ul(:id => 'pageValidationList')}
  element(:message)                             {|b| b.message_list.li(:class => 'uif-infoMessageItem')}
  element(:messages)                            {|b| b.lis(:class => 'uif-infoMessageItem')}
  value(:message_header)                        {|b| b.iframeportlet.h3(:class => 'uif-pageValidationHeader').text}
  value(:all_messages)                          {|b| b.messages.each {|msg| [] << msg.text}}

  # -- Error Handling --
  element(:error)                               {|b| b.message_list.li(:class => 'uif-errorMessageItem')}
  element(:errors)                              {|b| b.message_list.lis(:class => 'uif-errorMessageItem')}
  value(:all_errors)                            {|b| ary = [] ; b.errors.each {|msg| ary << msg.text} ; ary}

  # -- Buttons --
  element(:submit_button)                       {|b| b.iframeportlet.button(:id => "submitEditor")}
  element(:cancel_button)                       {|b| b.iframeportlet.button(:id => "cancelEditor")}
  element(:close_button)                        {|b| b.iframeportlet.button(:id => "closeEditor")}
  element(:return_to_search_button)             {|b| b.iframeportlet.button(:id => "returnToSearch_button")}

  # -- Navigation Area Elements --
  action(:delete_bib)                           {|b| b.iframeportlet.button(:title => 'Delete Bib').when_present.click}
  action(:add_instance)                         {|b| b.iframeportlet.button(:title => 'Add Instance').when_present.click}
  element(:add_einstance_button)                {|b| b.iframeportlet.button(:title => 'Add EInstance')}
  element(:holdings_link)                       {|i,b| b.iframeportlet.span(:xpath => "//div[@id='holdingsItemTree_tree']/ul[@class='jstree-no-icons']/li[#{i}]/a/span[@class='uif-message']")}
  element(:holdings_icon)                       {|i,b| b.iframeportlet.ins(:xpath => "//div[@id='holdingsItemTree_tree']/ul[@class='jstree-no-icons']/li[#{i}]/ins")}
  element(:item_link)                           {|which_holdings,which_item,b| b.iframeportlet.a(:xpath => "//div[@id='holdingsItemTree_tree']/ul[@class='jstree-no-icons']/li[#{which_holdings}]/ul/li[#{which_item}]/a")}
  # @note Vakata Context Menu items are only present on the screen after the containing menu header has been right-clicked.
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
