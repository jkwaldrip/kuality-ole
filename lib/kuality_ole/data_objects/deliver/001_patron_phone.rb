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

class PatronPhone < LineObject
  def initialize(browser,opts = {})
    @browser = browser
    defaults = {
      :number     => "#{random_num_string(3)}-#{random_num_string(3)}-#{random_num_string(4)}",
      :country    => KualityOle::Country,
      :preferred  => true,
      :active     => true
    }
    set_opts_attribs(defaults.merge(opts))
  end

  def create
    on PatronPhoneTab do |tab|
      autofill tab,[
        :number,
        :country,
        :preferred,
        :active
      ]
      tab.add
      tab.wait_till_loaded
      tab.number(:added,@index).wait_until_present
    end
  end
end

class PatronPhoneLine < LineCollection
  contains PatronPhone
end