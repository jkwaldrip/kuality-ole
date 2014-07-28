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

describe 'An Item Record' do

  let(:item)                    {ItemRecord.new}

  it 'has a record number' do
    expect(item.number).to be_a(Fixnum)
  end

  it 'defaults to record 1' do
    expect(item.number).to eq(1)
  end

  it 'has a barcode' do
    expect(item.barcode).to be_a(String)
  end

  it 'uses a default barcode prefix' do
    expect(item.barcode).to match(/^OLEQA/)
  end

  it 'has a type' do
    expect(item.type).to be_a(String)
    expect(item.type).to eq('Book')
  end

  it 'has a status' do
    expect(item.status).to be_a(String)
    expect(item.status).to eq('Available')
  end
end
