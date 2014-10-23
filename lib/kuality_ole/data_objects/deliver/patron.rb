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

# A patron in the OLE Library System.
#
#   Patron types are institution specific, and can be defined in
#     config/institutional/patron_types.yml
#
class Patron < DataFactory

  # Options:
  #
  #   :barcode    String        The barcode to use; format may be restricted by institutions.
  #   :type       String        The patron type to use.
  #                             (See .get_type for a list of acceptable values.)
  #   :source     String        The patron source to select.
  #   :name       String        The patron name, first and last, separated by a space.
  #   :address    Object        A line collection of PatronAddress data objects.
  #   :phone      Object        A line collection of PatronPhone data objects.
  #   :email      Object        A line collection of PatronEmail data objects.
  #
  def initialize(browser,opts={})
    @browser = browser
    defaults = {
      :barcode    => random_num_string(10,'OleQA'),
      :type       => 'default',
      :source     => '::random::',
      :name       => random_name,
      :address    => line('PatronAddress'),       # Add with :unshift
      :phone      => line('PatronPhone'),         # Add with :push
      :email      => line('PatronEmail')          # Add with :unshift
    }
    options = defaults.merge(opts)
    options[:type]        = get_type(options[:type])
    options[:first_name]  ||= options[:name].split(' ')[0]
    options[:last_name]   ||= options[:name].split(' ')[-1]
    set_opts_attribs(options)
  end

  # Create the patron record in the OLE library system.
  def create
    visit PortalPage do |page|
      page.deliver_tab.when_present.click
      page.link(:text => 'Patron').when_present.click
    end
    on PatronLookupPage do |page|
      page.create_new
    end
    on PatronPage do |page|
      page.set_description
      @header = page.get_header_info
      autofill page,[
        :type,
        :source,
        :barcode,
        :first_name,
        :last_name
      ]
      # If additional addresses, phone numbers, or email address are added,
      # be sure to set :preferred => false for each additional address.
      # Don't worry about the order, the push/unshift add will take care of that.
      # The preferred address should just always be the first address added.
      address.add :unshift,:type => 'Home'
      phone.add   :push
      email.add   :unshift
      page.submit
      page.wait_until_loaded
      expect(page.all_errors.join('; ')).to eq('')
      expect(page.all_messages.join =~ /Document was successfully submitted/i).to be_truthy
    end
  end

  # Lookup the patron record by the method specified.
  #
  # Params:
  #   how       Symbol      The search method to use.
  #                         Supported:  :name,:barcode
  #
  def lookup(how=:barcode)
  end

  # # Add a new address to the @address array.
  # def add_address(opts = {})
  #   @addresses.unshift PatronAddress.new(@browser,opts)
  # end
  #
  # # Add a new phone number to the @phone array.
  # def add_phone(create = false,opts = {})
  #   @phones.unshift PatronPhone.new(@browser,opts)
  # end
  #
  # # Add a new email address to the @email array.
  # def add_email(create = false,opts = {})
  #   @emails.unshift PatronEmail.new(@browser,opts)
  # end
  #
  # # Enter a patron address from the @addresses array.
  # def enter_address(which = 0)
  #   enter @addresses,which
  # end
  #
  # # Enter a patron phone number from the @phones array.
  # def enter_phone(which = 0)
  #   enter @phones,which
  # end
  #
  # # Enter a patron email address from the @emails array.
  # def enter_email(which = 0)
  #   enter @emails,which
  # end

  # -- PRIVATE --
  private

  # Lookup a patron type by general role.
  #
  # Specific patron types are defined in:
  #   config/institutional/patron_types.yml
  #
  # Supported types:
  #   :default
  #   :undergrad
  #   :grad_student
  #   :faculty
  #   :staff
  #
  def get_type(patron_type)
    types = YAML.load_file('config/institutional/patron_types.yml')
    patron_type = keyify(patron_type) if patron_type.is_a?(String)
    types[patron_type]
  end

end
