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

# The MARC Bibliographic Record Editor in the OLE Library System.
class BibEditorPage < MarcEditorPage

  # -- MARC Data Lines --
  # - Pass a 0-based locator (i) to dynamically select line elements.
  element(:tag_field)                           {|i,b| b.iframeportlet.text_field(:id => "dataField_tag_id_line#{i}_control")}
  element(:ind_1_field)                         {|i,b| b.iframeportlet.text_field(:id => "dataField_ind1_id_line#{i}_control")}
  element(:ind_2_field)                         {|i,b| b.iframeportlet.text_field(:id => "dataField_ind2_id_line#{i}_control")}
  element(:value_field)                         {|i,b| b.iframeportlet.text_field(:id => "dataField_value_id_line#{i}_control")}
  element(:add_button)                          {|i,b| b.iframeportlet.button(:id => "dataField_addTagButton_id_line#{i}")}
  element(:remove_button)                       {|i,b| b.iframeportlet.button(:id => "dataField_removeTagButton_id_line#{i}")}
  # - Data Line Control -
  action(:add_line)                             {|i,b| b.add_button(i).when_present.click}
  action(:remove_line)                          {|i,b| b.remove_button(i).when_present.click}

  alias_method(:indicator_1_field,:ind_1_field)
  alias_method(:indicator_2_field,:ind_2_field)

end
