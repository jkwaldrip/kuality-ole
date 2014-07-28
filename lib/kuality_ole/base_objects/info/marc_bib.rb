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

# A MARC format bibliographic record in the OLE Library System.
#   This class serves as a container for MARC record bibliographic data.
class MarcBib < InfoObject

  # Params:
  #   :title              String        The title on the bib record.    (Marc 245 $a)
  #   :author             String        The author on the bib record.   (Marc 100 $a)
  #   :marc_lines         Array         An array of MARC data values not named above,
  #                                     instantiated as MarcDataLine objects.
  #                                     (See lib/kuality_ole/base_objects/etc/marc_data_line.rb)
  def initialize(opts={})
    defaults = {
        :title                => random_letters(pick_range(9..13)).capitalize,
        :author               => random_name,
        :marc_lines           => [],
    }

    @options = defaults.merge(opts)
    opts_to_vars(@options)

    # Add MARC Data Lines for title and author.
    @marc_lines.unshift(
        MarcDataLine.new(:tag => '100',:subfield => '|A',:value => @title),
        MarcDataLine.new(:tag => '245',:subfield => '|A',:value => @author)
    )

  end
end
