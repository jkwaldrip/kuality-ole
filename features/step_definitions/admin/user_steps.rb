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

Given /^I am ([\w\-\_]+)$/ do |username|
  if username[/(default|any|a user)/]
    @user = User.new @browser,:role => 'default',:lookup_role? => true
  # TODO create a catch for role, e.g. 'I am an acquisitions user','I am a circulation user'
  else
    @user = User.new @browser,:username => username
  end
end

Then /^I login$/ do
  @user.open_portal
  expect(@user.login).to be_truthy
end

Then /^I logout$/ do
  @user.logout
end
