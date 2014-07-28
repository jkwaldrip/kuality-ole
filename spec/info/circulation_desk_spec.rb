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

describe 'A Circulation Desk' do

  before :all do
    @circulation_desk = CirculationDesk.new
  end

  it 'has a desk code' do
    expect(@circulation_desk.code).to be_a(String)
  end

  it 'has a name' do
    expect(@circulation_desk.code).to be_a(String)
  end

  it 'has an array of locations' do
    expect(@circulation_desk.locations).to be_an(Array)
    expect(@circulation_desk.locations[0]).to be_a(String)
  end

  it 'returns an error if a desk code is not found' do
    expect {CirculationDesk.new(:code => 'THISDESKDOESNOTEXIST')}.to raise_error(KualityOle::Error)
  end

end
