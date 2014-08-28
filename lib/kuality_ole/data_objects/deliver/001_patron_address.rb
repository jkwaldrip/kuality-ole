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

class PatronAddress < LineObject
  def initialize(browser, opts = {})
    @browser = browser
    defaults = {
      :type         => '::random::',
      :source       => '::random::',
      :line_1       => "#{random_num_string(3)} #{random_letters(pick_range(3..12)).capitalize} #{random_letters(2).capitalize}",
      :line_2       => random_letters(pick_range(3..6)).capitalize,
      :line_3       => random_letters(pick_range(3..6)).capitalize,
      :city         => random_letters(pick_range(6..12)).capitalize,
      :state        => KualityOle::States.sample.upcase,
      :postal_code  => random_num_string(5),
      :country      => KualityOle::Country,
      :valid_from   => '',
      :valid_to     => '',
      :verified     => true,
      :preferred    => true,
      :active       => true
    }
    set_opts_attribs(defaults.merge(opts))
  end

  def create
    on PatronAddressTab do |tab|
      tab.toggle_details unless tab.expanded?(:new)
      autofill tab,[
        :type,
        :source,
        :valid_from,
        :valid_to,
        :verified,
        :preferred,
        :active,
        :line_1,
        :line_2,
        :line_3,
        :city,
        :state,
        :postal_code,
        :country
      ]
      tab.add
      tab.wait_until_loaded
      tab.toggle_details(:new)                          # Expand new line.
      tab.line_1(:new).wait_until_present
      tab.wait_until_loaded
      @collection.count.times do |i|                    # Expand each line.
        tab.toggle_details :added,i
        tab.wait_until_loaded
        tab.line_1(:added,i).wait_until_present
      end
    end
  end
end

class PatronAddressLine < LineCollection
  contains PatronAddress
end
