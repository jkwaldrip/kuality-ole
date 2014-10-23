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

describe 'A Resource' do

  before :all do
    @browser  = KualityOle.start_browser
    @resource     = Resource.new @browser
  end

  after :all do
    @browser.quit unless @browser.nil?
  end

  it 'has a bib record' do
    expect(@resource.bib_record).to be_a(MarcBib)
  end

  it 'has one default holdings record' do
    expect(@resource.holdings.count).to eq(1)
    expect(@resource.holdings[0]).to be_a(HoldingsRecord)
  end

  it 'can create a new holdings record' do
    @resource.new_holdings
    expect(@resource.holdings.count).to eq(2)
    expect(@resource.holdings[1]).to be_a(HoldingsRecord)
  end

  it 'has one default item record' do
    expect(@resource.holdings[0].items.count).to eq(1)
    expect(@resource.holdings[0].items[0]).to be_an(ItemRecord)
  end

  it 'can create a new item record' do
    @resource.new_item(0)
    expect(@resource.holdings[0].items.count).to eq(2)
    expect(@resource.holdings[0].items[1]).to be_an(ItemRecord)
  end

  it 'can convert a MarcBib to Ruby-Marc format' do
    expect(@resource.to_mrc).to be_truthy
    expect(@resource.bib.record).to be_a(MARC::Record)
  end

  it 'can be created with a bib object' do
    bib = MarcBib.new
    expect(Resource.new(@browser,:bib => bib)).to be_a(Resource)
  end
end
