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

# For 'I have an item', see features/step_definitions/describe/marc_editor_steps.
# This step supports setting multiple item statuses on a resource:
#   Available, In Process, On Order, etc.
Given /^I have an? (\w+\s?){1,2} (?:item|resource)$/i do |item_status|
  item_status.replace item_status.split(' ').collect {|s| s.capitalize}.join(' ')
  # TODO - Once OLE-6917 is fixed, add support for setting item_status
  @resource = create Resource unless @resource
  unless @patron
    @patron = create Patron
  end
end

When /^I (?:loan|check out) the item$/ do
  @resource.loan_to @patron
end

When /^I return the item$/ do
  @resource.return
end
