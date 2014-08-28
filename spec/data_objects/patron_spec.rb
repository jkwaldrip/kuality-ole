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

describe 'A patron' do

  before :all do
    @browser = KualityOle.start_browser
  end

  after :all do
    @browser.quit unless @browser.nil?
  end

  context 'created with defaults' do
    let(:patron)              {Patron.new(@browser)}

    it 'has a name' do
      expect(patron.name).to match(/\w+\ \w+/)
    end

    it 'has a first name' do
      expect(patron.first_name).to be_a(String)
    end

    it 'has a last name' do
      expect(patron.last_name).to be_a(String)
    end

    it 'has a barcode' do
      expect(patron.barcode).to be_a(String)
    end

    it 'has a street address' do
      expect(patron.address).to be_a(LineCollection)
    end

    it 'has a phone number' do
      expect(patron.phone).to be_a(LineCollection)
    end

    it 'has an email address' do
      expect(patron.email).to be_a(LineCollection)
    end
  end

  context 'has a street address' do

    let(:address)             {PatronAddress.new(@browser)}

    it 'with a type' do
      expect(address.type).to match('::random::')
    end

    it 'with a source' do
      expect(address.source).to match('::random::')
    end

    it 'with a valid from date' do
      expect(address.valid_from).to eq('')
    end

    it 'with a valid to date' do
      expect(address.valid_to).to eq('')
    end

    it 'which is verified' do
      expect(address.verified).to be_true
    end

    it 'which is preferred' do
      expect(address.preferred).to be_true
    end

    it 'which is active' do
      expect(address.active).to be_true
    end

    it 'with a line 1' do
      expect(address.line_1).to match(/\d+ \w+ \w+/)
    end

    it 'with a line 2' do
      expect(address.line_2).to be_a(String)
    end

    it 'with a line 3' do
      expect(address.line_3).to be_a(String)
    end

    it 'with a city' do
      expect(address.city).to be_a(String)
    end

    it 'with a state' do
      expect(address.state).to be_a(String)
    end

    it 'with a postal code' do
      expect(address.postal_code).to match(/\d{5}/)
    end

    it 'with a country' do
      expect(address.country).to eq(KualityOle::Country)
    end
  end

  context 'has a phone number' do

    let(:phone)               {PatronPhone.new(@browser)}

    it 'with a number' do
      expect(phone.number).to match(/\d{3}\-\d{3}\-\d{4}/)
    end

    it 'with a country' do
      expect(phone.country).to eq(KualityOle::Country)
    end

    it 'which is preferred' do
      expect(phone.preferred).to be_true
    end

    it 'which is active' do
      expect(phone.active).to be_true
    end
  end

  context 'has an email address' do

    let(:email)               {PatronEmail.new(@browser)}

    it 'with an address' do
      expect(email.address).to match(/\w+\@\w+\.\w{3}/)
    end

    it 'which is preferred' do
      expect(email.preferred).to be_true
    end

    it 'which is active' do
      expect(email.active).to be_true
    end
  end

  context 'selected by type' do
    let(:patron)              {Patron.new(@browser,:type => 'faculty')}

    it 'has an appropriate type' do
      expect(patron.type).to eq('Faculty')
    end
  end
end
