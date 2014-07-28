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

describe 'A Holdings Record' do

  let(:holdings)                    {HoldingsRecord.new}

  it 'has a record number' do
    expect(holdings.number).to be_a(Fixnum)
  end

  it 'defaults to record 1' do
    expect(holdings.number).to eq(1)
  end

  it 'has a circulation desk' do
    expect(holdings.circulation_desk).to be_a(CirculationDesk)
  end

  it 'has a location' do
    expect(holdings.location).to be_a(String)
  end

  it 'has a call number' do
    expect(holdings.call_number).to be_a(String)
  end

  it 'has a call number type' do
    expect(holdings.call_number_type).to be_a(String)
  end

  it 'defaults to call number type LCC' do
    expect(holdings.call_number_type).to eq('LCC')
  end

  it 'has an item record' do
    expect(holdings.items).to be_an(Array)
    expect(holdings.items[0]).to be_an(ItemRecord)
  end

  it 'creates a new item record' do
    holdings.new_item
    expect(holdings.items.count).to eq(2)
    expect(holdings.items[1]).to be_an(ItemRecord)
  end

end
