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

Given /^I have a resource$/ do
  @resource = MarcRecord.new @browser
end

When /^I enter a new bib record$/ do
  @resource.create_bib
end

When /^I enter a new holdings record$/ do
  @resource.create_holdings
end

When /^I enter a new item record$/ do
  @resource.create_item
end
