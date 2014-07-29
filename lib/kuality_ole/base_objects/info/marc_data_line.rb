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
#  limitations under the License

# A single line on a MARC record.
class MarcDataLine < InfoObject

  include KualityOle::Helpers

  attr_accessor :tag,:indicator_1,:indicator_2,:subfield_code,:subfield,:value

  alias :ind_1 :indicator_1
  alias :ind_1= :indicator_1=
  alias :ind_2 :indicator_2
  alias :ind_2= :indicator_2=

  # Parameters:
  #   :tag              String        The MARC field tag
  #   :indicator_1      String        The first subfield indicator.
  #   :indicator_2      String        The second subfield indicator.
  #   :subfield_code    String        The MARC subfield code/subfield delimiter.
  #   :value            String        The actual value of the field, without delimiter.
  #
  # @note In the OLE Library System, MARC subfields are delimited with a
  #   vertical bar '|' instead of the standard dollar sign '$', and the
  #   subfield code is usually a capital letter.
  #   These substitutions will be made automatically.
  #
  def initialize(opts={})
    defaults = {
        :tag          => '245',
        :subfield     => '|a',
        :indicator_1  => '#',
        :indicator_2  => '#',
        :value        => random_letters(pick_range(6..10)).capitalize
    }
    options = defaults.merge(opts)

    @tag              = options[:tag]
    @subfield_code    = options[:subfield].gsub(/(?<=^)\$/,'|').downcase
    @indicator_1      = options[:indicator_1]
    @indicator_2      = options[:indicator_2]
    @value            = options[:value]
    @subfield         = "#{@subfield_code} #{value}"
  end
end
