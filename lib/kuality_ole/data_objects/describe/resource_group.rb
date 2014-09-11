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

# A group of Resource data objects.
#
#   This class is primarily used to handle read/write operations on
#   multiple MARC records in a single file.
class ResourceGroup < DataFactory

  # Options:
  #   :records      Array         An array of Resource data objects.
  #
  def initialize(browser,opts={})
    @browser = browser
    defaults = {:resources => collection(Resource)}
    options = defaults.merge(opts)
    set_opts_attribs(options)
  end

  # Write all records to a file.
  # @note These options will become accessor attributes.
  #
  # Options:
  #   :filename       String      The name of the file to write to.
  #   :path           String      The path in which the file should be found.
  #
  def to_file(opts={})
    defaults = {
      :filename   => "#{random_letters(3)}-#{KualityOle.timestamp}.mrc",
      :path   => 'data/uploads/mrc/'
    }
    set_opts_attribs(defaults.merge(opts))
    @filename += '.mrc' unless @filename[/\.mrc$/]
    @path     += '/' unless @path[/\/$/]
    writer = MARC::Writer.new(File.expand_path(@path + @filename))
    @resources.each do |resource|
      writer.write(resource.to_mrc)
    end
    writer.close
  end
  alias_method(:write_to_file,:to_file)

  class << self

    # Create a new instance of this class by loading records from a Marc (.mrc) file.
    # @note This will create @path and @filename accessors on the new instance.
    #
    # Params:
    #
    #   browser       Object      The Watir::Browser instance to pass to the new data object.
    #
    #   file          String      The full path and filename for the MARC record.
    #
    def from_file(browser,file)
      opts = {
        :filename     => file.split('/')[-1],
        :path         => file.match(/(^.*\/)(?:[\w\_\-\.]+$)/)[1]
      }
      klas = self.new(@browser,opts)
      MARC::Reader.new(file).collect {|rec| MarcBib.from_record(rec)}.each do |bib|
        klas.resources.add_only :bib => bib
      end
      klas
    end
    alias_method(:new_from_file,:from_file)
  end
end
