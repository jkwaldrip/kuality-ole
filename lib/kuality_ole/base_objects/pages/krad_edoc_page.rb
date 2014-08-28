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

# A routable e-Document page built in KRAD.
class KradEdocPage < KradPage

  # -- Document Header Info --
  # @note If it's made universally present, the data-label attribute provides a clearer, easier identifier
  #   for the first four header info elements.
  value(:document_number)                 {|b| b.iframeportlet.div(:class => 'uif-documentNumber').span(:class => 'uif-readOnlyContent').when_present.text.strip}
  value(:status)                          {|b| b.iframeportlet.div(:class => 'uif-documentStatus').span(:class => 'uif-readOnlyContent').when_present.text.strip}
  value(:initiator_id)                    {|b| b.iframeportlet.div(:class => 'uif-documentInitiatorNetworkId').span(:class => 'uif-readOnlyContent').when_present.text.strip}
  value(:timestamp)                       {|b| b.iframeportlet.div(:class => 'uif-documentCreateDate').span(:class => 'uif-readOnlyContent').when_present.text.strip}

  # -- Document Overview --
  # @note Some pages will use an overview section separate from the document overview section.
  action(:toggle_doc_overview)            {|b| b.iframeportlet.a(:id => 'note_toggle').when_present.click }
  element(:description)                   {|b| b.iframeportlet.text_field(:id => 'documentDescription_control')}
  element(:org_doc_number)                {|b| b.iframeportlet.text_field(:id => 'organizationDocumentNumber_control')}
  element(:explanation)                   {|b| b.iframeportlet.text_field(:id => 'explanation_control')}
  action(:set_description)                {|b| b.description.when_present.set("AFT - #{KualityOle.timestamp}")}
  action(:get_header_info)                {|b| hsh = {
                                            :document_number    => b.document_number,
                                            :status             => b.status,
                                            :initiator_id       => b.initiator_id,
                                            :timestamp          => b.timestamp
                                            }
                                          }

  # -- Control Elements --
  element(:submit_button)                 {|b| b.iframeportlet.button(:id => 'oleSubmit')}
  action(:submit)                         {|b| b.submit_button.when_present.click ; b.status}
  element(:save_button)                   {|b| b.iframeportlet.button(:id => 'usave')}
  action(:save)                           {|b| b.save_button.when_present.click ; b.status}
  element(:back_button)                   {|b| b.iframeportlet.button(:id => 'oleClose')}
  element(:cancel_button)                 {|b| b.iframeportlet.a(:id => 'ucancel')}

end
