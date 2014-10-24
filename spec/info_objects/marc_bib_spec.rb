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

describe 'A MARC Bib Record' do

  context 'created normally' do

    before :all do
      @bib = MarcBib.new
      @info = {}
    end

    it 'has a title' do
      expect(@bib.title).to be_a(String)
    end

    it 'has an author' do
      expect(@bib.author).to be_a(String)
    end

    it 'has a control 008 field' do
      expect(@bib.control_008).to be_a(String)
    end

    it 'has a leader field' do
      expect(@bib.leader).to be_a(String)
    end

    it 'has an array of Marc lines' do
      expect(@bib.marc_lines).to be_an(Array)
    end
  
    it 'has the title as a Marc line' do
      expect(@bib.marc_lines[0].values[0]).to eq(@bib.title)
    end

    it 'has the author as a Marc line' do
      expect(@bib.marc_lines[1].values[0]).to eq(@bib.author)
    end

    it 'updates the title' do
      @bib.marc_lines[0].values[0] = 'New Testing Title'
      expect(@bib.title).to eq 'New Testing Title'
    end

    it 'updates the author' do
      @bib.marc_lines[1].values[0] = 'New Testing Author'
      expect(@bib.author).to eq 'New Testing Author'
    end

    it 'can be converted to a .mrc record' do
      expect(@bib.to_mrc).to be_truthy
      expect(@bib.record).to be_a(MARC::Record)
    end

    it 'can be written to a file' do
      expect(@bib.to_file).to be_truthy
      expect(File.exists?("data/uploads/mrc/#{@bib.filename}")).to be_truthy
    end

    it 'can overwrite a previous file' do
      expect(File.exists?(@bib.path + @bib.filename)).to be_truthy
      expect(@bib.to_file(:filename => @bib.filename,:force? => true)).to be_truthy
    end

  end

  context 'created from a Ruby-Marc record' do

    before :all do
      # This record is formatted for compatibility with OLE, just for reference.
      @record = MARC::Record.new
      @record.leader = '00168nam a2200073 a 4500'
      @record.append MARC::ControlField.new('008','140212s        xxu           000 0 eng d')
      @record.append MARC::DataField.new('245','0','0',['a','Test Title'])
      @record.append MARC::DataField.new('100','0','0',['a','Test Author'])
      @bib = MarcBib.from_marc(@record)
    end

    it 'has a title' do
      expect(@bib.title).to eq('Test Title')
    end

    it 'has an author' do 
      expect(@bib.author).to eq('Test Author')
    end

    it 'has a control 008 field' do
      expect(@bib.control_008).to eq('140212s        xxu           000 0 eng d')
    end

    it 'has the title as a data line' do
      title = @bib.marc_lines.detect {|line| line.tag == '245'}
      expect(title.tag).to eq('245')
      expect(title.ind_1).to eq('0')
      expect(title.ind_2).to eq('0')
      expect(title.subfield_codes).to eq(['|a'])
      expect(title.values).to eq(['Test Title'])
      expect(title.subfield).to eq('|a Test Title')
    end

    it 'has the author as a data line' do
      author = @bib.marc_lines.detect {|line| line.tag == '100'}
      expect(author.tag).to eq('100')
      expect(author.ind_1).to eq('0')
      expect(author.ind_2).to eq('0')
      expect(author.subfield_codes).to eq(['|a'])
      expect(author.values).to eq(['Test Author'])
      expect(author.subfield).to eq('|a Test Author')
    end

  end

end
