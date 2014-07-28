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

dir = File.expand_path(File.dirname(__FILE__) + '/../')
$:.unshift(dir) unless $:.include?(dir)

require 'rspec'
require 'lib/kuality-ole'

RSpec.configure do |config|

  # Headless needs to be started only once to avoid 'XVFB is frozen' errors.
  # Unfortunately, instance variables are out of scope in before(:suite),
  # so a global variable is the best solution.
  config.before(:suite) do
    $headless = Headless.new
    $headless.start
  end

  config.after(:suite) do
    $headless.destroy
  end

end
