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

# An OLE Library System Holdings record.
class HoldingsRecord < InfoObject

  attr_accessor :number,:circulation_desk,:call_number,:call_number_type,:location

  # Params:
  #   :number             Fixnum        The 1-based sequential number representing the record's
  #                                     place under the bib record.
  #                                     (See lib/kuality_ole/data_objects/describe/marc_record.rb)
  #   :circulation_desk   Object        The OLE circulation desk to use.
  #                                     (See lib/kuality_ole/base_objects/etc/circulation_desk.rb)
  #   :call_number        String        The call number to use on the holdings record.
  #   :call_number_type   String        The holdings call number type.
  #   :location           String        The location for the holdings record.
  #                                     Defaults to a random selection from :circulation_desk.
  #                                     (See lib/kuality_ole/base_objects/etc/circulation_desk.rb)
  def initialize(opts={})
    defaults = {
        :number               => 1,
        :circulation_desk     => CirculationDesk.new,
        :call_number          => random_lcc,
        :call_number_type     => 'LCC',
        :items                => [ItemRecord.new]
    }

    @options = defaults.merge(opts)

    # Select a Holdings location from the Circulation desk unless given.
    @options[:location] ||= @options[:circulation_desk].locations.sample

    set_opts_attribs(@options)
  end

  # Create a new Item Record.
  def new_item(opts={})
    defaults = {:number => @items.count + 1}
    @items << ItemRecord.new(defaults.merge(opts))
  end
end
