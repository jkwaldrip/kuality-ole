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

  context 'with a single subfield' do

    let(:marc_data_line)       {MarcDataLine.new}

    it 'has a default tag value' do
      expect(marc_data_line.tag).to eq('245')
    end

    it 'has default indicator values' do
      expect(marc_data_line.indicator_1).to eq('#')
      expect(marc_data_line.indicator_2).to eq('#')
    end

    it 'has a default subfield code' do
      expect(marc_data_line.subfield_codes).to eq(['|a'])
    end

    it 'has a full subfield value' do
      expect(marc_data_line.subfield).to match(/^\|a [\w]+/)
    end

    it 'has a data value' do
      expect(marc_data_line.values.count).to eq(1)
      expect(marc_data_line.values[0]).to match(/^[\w]+$/)
    end
  end

  context 'with multiple subfields' do
    
    let(:marc_data_line)       {MarcDataLine.new(
                                :tag              => '245',
                                :indicator_1      => '0',
                                :indicator_2      => '4',
                                :subfield_codes   => ['a','b'],
                                :values           => ['The Testing Title','A work in two parts']
                                )}

    it 'has a tag' do
      expect(marc_data_line.tag).to eq('245')
    end

    it 'has indicators' do
      expect(marc_data_line.indicator_1).to eq('0')
      expect(marc_data_line.indicator_2).to eq('4')
    end

    it 'has two subfield codes' do
      expect(marc_data_line.subfield_codes.count).to eq(2)
      expect(marc_data_line.subfield_codes[0]).to eq('|a')
      expect(marc_data_line.subfield_codes[1]).to eq('|b')
    end

    it 'has a full subfield value' do
      expect(marc_data_line.subfield).to eq('|a The Testing Title |b A work in two parts')
    end

    it 'has two values' do
      expect(marc_data_line.values.count).to eq(2)
      expect(marc_data_line.values[0]).to eq('The Testing Title')
      expect(marc_data_line.values[1]).to eq('A work in two parts')
    end
  end

  context 'created from a Ruby-Marc DataField' do

    context 'with one subfield' do
      before :all do
        data_field                = MARC::DataField.new('245','0','0',['a','Title'])
        @data_line                = MarcDataLine.from_field(data_field)
      end

      it 'has a tag' do
        expect(@data_line.tag).to eq('245')
      end

      it 'has indicators' do
        expect(@data_line.indicator_1).to eq('0')
        expect(@data_line.indicator_2).to eq('0')
      end

      it 'has a subfield code' do
        expect(@data_line.subfield_codes.count).to eq(1)
        expect(@data_line.subfield_codes[0]).to eq('|a')
      end

      it 'has a value' do
        expect(@data_line.values.count).to eq(1)
        expect(@data_line.values[0]).to eq('Title')
      end

      it 'has a full subfield value' do
        expect(@data_line.subfield).to eq('|a Title')
      end
    end

    context 'with two subfields' do

      before :all do
        data_field                = MARC::DataField.new('245','0','0',['a','Title'],['b','Subtitle'])
        @data_line                = MarcDataLine.from_field(data_field)
      end

      it 'has a tag' do
        expect(@data_line.tag).to eq('245')
      end

      it 'has indicators' do
        expect(@data_line.indicator_1).to eq('0')
        expect(@data_line.indicator_2).to eq('0')
      end

      it 'has subfield codes' do
        expect(@data_line.subfield_codes.count).to eq(2)
        expect(@data_line.subfield_codes[0]).to eq('|a')
        expect(@data_line.subfield_codes[1]).to eq('|b')
      end

      it 'has values' do
        expect(@data_line.values.count).to eq(2)
        expect(@data_line.values[0]).to eq('Title')
        expect(@data_line.values[1]).to eq('Subtitle')
      end

      it 'has a complete subfield value' do
        expect(@data_line.subfield).to eq('|a Title |b Subtitle')
      end
    end
  end
end
