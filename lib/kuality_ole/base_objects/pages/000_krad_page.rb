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

# The base page object for all KRAD-based pages in OLE.
class KradPage < BasePage

  uses_frames

  # -- Message Handling --
  element(:message_list)                        {|b| b.iframeportlet.ul(:id => 'pageValidationList')}
  element(:message)                             {|b| b.message_list.li(:class => 'uif-infoMessageItem')}
  element(:messages)                            {|b| b.lis(:class => 'uif-infoMessageItem')}
  value(:message_header)                        {|b| b.iframeportlet.h3(:class => 'uif-pageValidationHeader').text}
  value(:all_messages)                          {|b| b.messages.collect {|msg| msg.text.strip}}

  # -- Error Handling --
  element(:error)                               {|b| b.iframeportlet.li(:class => 'uif-errorMessageItem')}
  element(:errors)                              {|b| b.iframeportlet.lis(:class => 'uif-errorMessageItem')}
  value(:all_errors)                            {|b| b.errors.collect {|err| err.text.strip}}

end
