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

  # A title and an author will be pulled from the :marc_lines array if they are found there.
  # @note A bibliographic record in OLE requires at least a title (245 $a).
  #   To allow for failure-case testing, this class will accept an empty Marc lines array.
  #
  # Params:
  #   :marc_lines         Array         An array of MARC data values not named above,
  #                                     instantiated as MarcDataLine objects.
  #                                     Defaults to one title line and one author line.
  #                                     (See lib/kuality_ole/base_objects/etc/marc_data_line.rb)
  #
  #   :leader             String        The leader field on the bib record.
  #                                     In OLE, the default value is '00168nam a2200073 a 4500';
  #                                     this value is required for any records to be imported.
  #
  #   :control_008        String        The 008 control field on the bib record.  (Marc 008, Fixed-Length)
  #
  def initialize(opts={})
    defaults = {
        :marc_lines           => [
          MarcDataLine.new(:tag => '245',:subfield_codes => ['|a'],:values => [random_letters(pick_range(9..13)).capitalize]),
          MarcDataLine.new(:tag => '100',:subfield_codes => ['|a'],:values => [random_name])
        ],
        :leader               => '00168nam a2200073 a 4500',
        :control_008          => '140212s        xxu           000 0 eng d'
    }

    @options = defaults.merge(opts)
    @options[:title] = if @options[:marc_lines].detect {|line| line.tag == '245'} 
                         @options[:marc_lines].detect {|line| line.tag == '245'}.values.join
                       else
                         ''
                       end
    @options[:author] = if @options[:marc_lines].detect {|line| line.tag == '100'}
                          @options[:marc_lines].detect {|line| line.tag == '100'}.values.join
                        else
                          ''
                        end
    opts_to_vars(@options)

    # TODO Rewrite class and spec with expectation that :title and :author are derived, not parameters

  end

  # Convert the info in this MarcBib class to a RubyMarc record.
  # - Creates an @record instance variable on the MarcBib instance.
  # - Creates a :record accessor on the MarcBib instance.
  #
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
      @record.append(MARC::DataField.new(
        line.tag,
        line.ind_1,
        line.ind_2,
        *(line.subfield_codes.each_with_index.collect {|sfc,i| [sfc,line.values[i]]})
      ))
    end

    @record
  end
  alias_method(:to_marc,:to_mrc)

  # Write a single record to a Marc (.mrc) file.
  # @note This method expects an @title and an @record to exist!
  #   The intended usage is to invoke .to_mrc first, followed by .to_file
  #
  # Options:
  #       :filename           String          The name of the file, written to data/uploads/mrc/
  #       :path               String          The path of the file to be written.
  #       :force?             Boolean         Whether to overwrite an existing file.
  #
  def to_file(opts={})
    raise KualityOle::Error,"MARC::Record not found." unless @record.is_a?(MARC::Record)
    # TODO Create :format option to enable Marc-XML support.
    defaults = {      
      :filename         => "#{KualityOle.timestamp}-#{@title}.mrc",
      :path             => 'data/uploads/mrc/',
      :force?           => false
    }
    opts = defaults.merge(opts)
    opts[:filename] += '.mrc' unless opts[:filename][/\.mrc$/] # TODO Rewrite validation for Marc-XML support.
    opts[:path]     += '/' unless opts[:path][/\//]
    opts_to_vars(opts)

    if File.exists?("data/uploads/mrc/#{@filename}") && !opts[:force?]
      raise KualityOle::Error,"MARC file already exists, use the :force? => true option to overwrite.\n(Given: #{filename})."
    end

    writer = MARC::Writer.new("#{@path}#{@filename}")
    writer.write(@record)
  end

  class << self
    # Create a new MarcBib instance from an existing MARC::Record class.
    # @note The default MARC::Record leader value differs from OLE's preferred value,
    #   and may not be accepted by the system, especially in case of imports.
    #   See parameter notes on .initialize for more.
    #
    # Params:
    #     record        Object      An existing MARC::Record instance from the Ruby-Marc gem.
    #
    def from_marc(record)
      opts = {}
      opts[:leader]       = record.leader
      opts[:control_008]  = record.find {|field| field.tag == '008'}.value if record.tags.include?('008')
      opts[:marc_lines]   = Array.new( record.fields.select {|field| ! ('001'..'009').include?(field.tag) } ).collect do |fld|
        MarcDataLine.from_field(fld)
      end
      self.new(opts)
    end
    alias_method(:new_from_marc,:from_marc)
    alias_method(:from_record,:from_marc)
    alias_method(:new_from_record,:from_marc)
  end
end
