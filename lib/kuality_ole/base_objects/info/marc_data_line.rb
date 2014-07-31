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

  attr_accessor :tag,:indicator_1,:indicator_2,:subfield_codes,:subfield,:values

  alias :ind_1 :indicator_1
  alias :ind_1= :indicator_1=
  alias :ind_2 :indicator_2
  alias :ind_2= :indicator_2=

  # Parameters:
  #   :tag              String        The MARC field tag
  #   :indicator_1      String        The first subfield indicator.
  #   :indicator_2      String        The second subfield indicator.
  #   :subfield_codes   Array         An array of MARC subfield codes (delimiters).
  #   :values           String        An array of MARC subfield values (without delimiter).
  #                                  
  # Usage:
  #   -- Single Subfield --
  #
  #   MarcDataLine.new(:tag => '100',:subfield_codes => ['$a'],:values => ['Arthur Authorsen'])
  #
  #   -- Multiple Subfields --
  #   MarcDataLine.new(:tag => '245',
  #     :subfield_codess => ['$a','$b'],
  #     :values => ['Title of Book','Subtitle of book']
  #   )
  #
  # @note In the OLE Library System, MARC subfields are delimited with a
  #   vertical bar '|' instead of the standard dollar sign '$', and the
  #   subfield code is required to be a lowercase letter.
  #   These substitutions will be made automatically.
  #
  def initialize(opts={})
    defaults = {
        :tag              => '245',
        :indicator_1      => '#',
        :indicator_2      => '#',
        :subfield_codes   => ['|a'],
        :values           => [random_letters(pick_range(6..10)).capitalize]
    }
    options = defaults.merge(opts)

    @tag              = options[:tag]
    @subfield_codes   = options[:subfield_codes].collect {|sfc| sfc.gsub(/(?<=^)\$/,'').gsub(/^(?!\|)/,'|').downcase}
    @indicator_1      = options[:indicator_1]
    @indicator_2      = options[:indicator_2]
    @values           = options[:values]
    @subfield         = options.has_key?(:subfield) ? options[:subfield] : [@subfield_codes,@values].transpose.flatten.join(' ')
  end

  class << self
    # Create a new instance of MarcDataLine by passing in a MARC::DataField from Ruby-Marc.
    #
    # Params:
    #   obj     Object      An instance of a MARC::DataField from the Ruby-Marc gem.
    #
    def from_field(obj)
      opts = {
        :tag              => obj.tag,
        :indicator_1      => obj.indicator1,
        :indicator_2      => obj.indicator2,
        :subfield_codes   => obj.subfields.collect {|sf| sf.code},
        :values           => obj.subfields.collect {|sf| sf.value}
      }
      self.new(opts)
    end
    alias_method(:new_from_field,:from_field)
  end
end
