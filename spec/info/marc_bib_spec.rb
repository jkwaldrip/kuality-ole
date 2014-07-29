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

  it 'has an array of Marc lines' do
    expect(@bib.marc_lines).to be_an(Array)
  end
  
  it 'has the title as a Marc line' do
    expect(@bib.marc_lines[0].value).to eq(@bib.title)
  end

  it 'has the author as a Marc line' do
    expect(@bib.marc_lines[1].value).to eq(@bib.author)
  end

  it 'can be converted to a .mrc record' do
    expect(@bib.to_mrc).to be_true
    expect(@bib.record).to be_a(MARC::Record)
  end

  it 'can be written to a file' do
    expect(@bib.to_file).to be_true
    expect(File.exists?("data/uploads/mrc/#{@bib.filename}")).to be_true
  end

  it 'can overwrite a previous file' do
    expect(File.exists?(@bib.path + @bib.filename)).to be_true
    expect(@bib.to_file(:filename => @bib.filename,:force? => true)).to be_true
  end
end
