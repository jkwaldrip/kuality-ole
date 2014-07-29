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
  #   :control_008        String        The 008 control field on the bib record.  (Marc 008, Fixed-Length)
  def initialize(opts={})
    defaults = {
        :title                => random_letters(pick_range(9..13)).capitalize,
        :author               => random_name,
        :marc_lines           => [],
        :control_008          => '140212s        xxu           000 0 eng d'
    }

    @options = defaults.merge(opts)
    opts_to_vars(@options)

    # Add MARC Data Lines for title and author.
    @marc_lines.unshift(
        MarcDataLine.new(:tag => '100',:subfield => '|A',:value => @title),
        MarcDataLine.new(:tag => '245',:subfield => '|A',:value => @author)
    )

  end

  # Convert the info in this MarcBib class to a RubyMarc record.
  # Options:
  #       :record             Object          The MARC::Record instance to which lines will be appended.
  #
  def to_mrc(opts={})
    defaults = {
      :record           => MARC::Record.new
    }
    opts = defaults.merge(opts)
    opts_to_vars(opts)
    @record.append(MARC::ControlField.new('008',@control_008)) # TODO Make this iterative for all control fields.
    @marc_lines.each do |line|
      @record.append(MARC::DataField.new(line.tag,line.ind_1,line.ind_2,[line.subfield_code,line.value]))
    end

    true
  end

  # Write the record to a Marc (.mrc) file.
  # @note This method expects a title to exist!
  # Options:
  #       :filename           String          The name of the file, written to data/uploads/mrc/
  #       :path               String          The path of the file to be written.
  #       :force?             Boolean         Whether to overwrite an existing file.
  #       :writer             Object          The MARC::Writer instance to which the file will be written.
  #
  def to_file(opts={})
    raise KualityOle::Error,"MARC::Record not found." unless @record.is_a?(MARC::Record)
    # TODO Create :format option to enable Marc-XML support.
    defaults = {      
      :filename         => "#{KualityOle.timestamp}-#{@title}.mrc",
      :path             => 'data/uploads/mrc/',
      :force?           => false
      # :writer is given in opts or created later.
    }
    opts = defaults.merge(opts)
    opts[:filename] += '.mrc' unless opts[:filename][/\.mrc$/] # TODO Rewrite validation for Marc-XML support.
    opts[:path]     += '/' unless opts[:path][/\//]
    opts_to_vars(opts)

    if File.exists?("data/uploads/mrc/#{@filename}") && !opts[:force?]
      raise KualityOle::Error,"MARC file already exists, use the :force? => true option to overwrite.\n(Given: #{filename})."
    end
    @writer ||= MARC::Writer.new("#{@path}#{@filename}")
    @writer.write(@record)
  end

  class << self
    # TODO Create a new MarcBib from an existing Marc (.mrc) file with RubyMarc.
    def from_mrc
    end
    alias_method(:new_from_mrc,:from_mrc)
  end
end
