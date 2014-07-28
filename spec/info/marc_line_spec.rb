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

describe 'A Marc Data Line' do

  let(:marc_data_line)       {MarcDataLine.new}

  it 'has a default tag value' do
    expect(marc_data_line.tag).to eq('245')
  end

  it 'has default indicator values' do
    expect(marc_data_line.indicator_1).to eq('#')
    expect(marc_data_line.indicator_2).to eq('#')
  end

  it 'has a default subfield code' do
    expect(marc_data_line.subfield_code).to eq('|a')
  end

  it 'has a full subfield value' do
    expect(marc_data_line.subfield).to match(/^\|a [\w]+/)
  end

  it 'has an actual data value' do
    expect(marc_data_line.value).to match(/^[\w]+$/)
  end
end
