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

describe 'A group of resources' do

  before :all do
    @browser      = KualityOle.start_browser
    @group        = ResourceGroup.new @browser
  end

  after :all do
    @browser.quit unless @browser.nil?
  end

  context 'created manually' do

    it 'contains a resource collection' do
      expect(@group.resources).to be_a(ResourceCollection)
    end

    it 'accepts additional Resource data objects' do
      @group.resources.add
      expect(@group.resources.count).to be(1)
    end

    it 'writes multiple records to a file' do
      expect(@group.write_to_file).to be_true
      expect(File.exists?(@group.path + @group.filename)).to be_true
    end
  end

  context 'created from a file' do

    before :all do
      @group = ResourceGroup.new_from_file(@browser,'spec/data/multi-record.mrc')
    end

    it 'contains multiple records' do
      expect(@group.resources).to be_a(ResourceCollection)
      expect(@group.resources.count).to eq(3)
      @group.resources.each do |resource|
        expect(resource).to be_a(Resource)
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
