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

# An OLE Library System Item record.
class ItemRecord < InfoObject

  attr_accessor :barcode,:number

  # Params:
  #   :number             Fixnum        The 1-based sequential number representing the record's
  #                                     place under the holdings record.
  #                                     (See lib/kuality_ole/data_objects/describe/marc_record.rb)
  #   :barcode            String        The barcode to use on the item record.
  def initialize(opts = {})
    defaults = {
        :number               => 1,
        :barcode              => random_num_string(pick_range(6..8),"OLEQA"),
        :type                 => 'Book',
        :status               => 'Available'
    }
    @options = defaults.merge(opts)

    set_opts_attribs(@options)
  end
end
