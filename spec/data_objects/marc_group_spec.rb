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

describe 'A group of Marc Records' do

  before :all do
    @browser      = KualityOle.start_browser
  end

  after :all do
    @browser.quit unless @browser.nil?
  end

  context 'created manually' do
    
    before :all do
      @record_1     = MarcRecord.new(@browser)
      @record_2     = MarcRecord.new(@browser)
      @record_3     = MarcRecord.new(@browser)
      @group        = MarcGroup.new(@browser, :records => [@record_1,@record_2,@record_3])
    end

    it 'contains several MarcRecord data objects' do
      expect(@group.records).to be_an(Array)
      expect(@group.records[0]).to be(@record_1)
      expect(@group.records[1]).to be(@record_2)
      expect(@group.records[2]).to be(@record_3)
    end

    it 'accepts additional MarcRecord data objects' do
      record = MarcRecord.new(@browser)
      @group.records.push(record)
      expect(@group.records[-1]).to be(record)
    end

    it 'writes multiple records to a file' do
      expect(@group.write_to_file).to be_true
      expect(File.exists?(@group.path + @group.filename)).to be_true
    end
  end

  context 'created from a file' do

    before :all do
      @group = MarcGroup.new_from_file(@browser,'spec/data/multi-record.mrc')
    end      

    it 'contains multiple records' do
      expect(@group.records).to be_an(Array)
      expect(@group.records.count).to eq(3)
      @group.records.each do |record|
        expect(record).to be_a(MarcRecord)
      end
    end

    it 'has a filename' do
      expect(@group.filename).to eq('multi-record.mrc')
    end

    it 'has a path' do
      expect(@group.path).to eq('spec/data/')
    end
  end
end
