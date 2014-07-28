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

# A circulation desk in the OLE Library System.
# @note Configuration data for this class can be found in config/institutional/circulation.yml
class CirculationDesk < InfoObject

  attr_reader :code,:name,:locations

  # Optionally pass a desk code value from config/institutional/circulation.yml.
  def initialize(desk_code='')
    raise KualityOle::Error,"Config file is empty: config/institutional/circulation.yml" if File.zero?('config/institutional/circulation.yml')
    src_ary     = YAML.load_file('config/institutional/circulation.yml')
    info_hsh    = desk_code.empty? ?
        src_ary.sample :
        src_ary.find {|desk| desk[:code] == desk_code}
    raise KualityOle::Error,"Circulation desk not found.#{" (Given #{desk_code})" unless desk_code.empty?}" if info_hsh.nil?
    @code       = info_hsh[:code]
    @name       = info_hsh[:name]
    @locations  = info_hsh[:locations]
  end

end
