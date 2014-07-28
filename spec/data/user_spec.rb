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
require 'rspec'
require 'spec_helper'

describe 'A User' do

  before :all do
    @browser = KualityOle::start_browser
    @user = User.new @browser
  end

  after :all do
    @browser.quit
    sleep 30
  end

  it 'has a default username' do
    expect(@user.username).to eq('ole-quickstart')
  end

  it 'has a name' do
    expect(@user.name).to eq('OLE Quickstart')
  end

  it 'has a default role' do
    expect(@user.role).to eq('default')
  end

  it 'can be looked up by role' do
    circ_user = User.new @browser,:lookup_role? => true,:role => 'circulation'
    expect(circ_user.username).to eq('dev2')
    expect(circ_user.name).to eq('Development 2')
    expect(circ_user.role).to eq('circulation')
  end

end