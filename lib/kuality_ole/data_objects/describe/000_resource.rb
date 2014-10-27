#  Copyright 2005-2014 The Kuali Foundation

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

# A MARC-format bibliographic resource in the OLE Library System
# @note MARC is the default format in OLE.  Holdings and Item
#   records can be created with MARC fields, but will be extracted
#   as related records in the OLE Markup Language (OLEML).
# @note MARC record subfield delimiters in OLE are flagged with a bar '|'
#   instead of a dollar sign '$'.
class Resource < DataFactory

  # The MarcBib instance to use.
  attr_accessor :bib

  # An array of HoldingsRecord instances to use.
  attr_accessor :holdings
  alias :bib_record         :bib
  alias :holdings_records   :holdings

  # Options:
  #   :bib                Object        The Marc Bib record to use.
  #                                     (See lib/kuality_ole/base_objects/etc/marc_bib.rb)
  #   :holdings           Array         An array of Holdings Records to use.
  #                                     (Defaults to 1 new holdings record.)
  #                                     (See lib/kuality_ole/base_objects/etc/holdings_record.rb)
  def initialize(browser,opts={})
    @browser = browser
    defaults = {
        :bib                  => MarcBib.new,
        :holdings             => [HoldingsRecord.new]
    }
    options = defaults.merge(opts)
    set_options(options)
  end

  def create
    create_bib
    # TODO Iterate
    create_holdings
    create_item
  end

  # Create a new Holdings Record.
  def new_holdings(opts={})
    defaults = {:number => @holdings.count + 1}
    @holdings << HoldingsRecord.new(defaults.merge(opts))
  end
  alias_method(:new_holdings_record,:new_holdings)

  # Create a new Item Record with the given options on the Holdings Record specified by array index.
  def new_item(which_holdings = 0,opts={})
    defaults = {:number => @holdings[which_holdings].items.count}
    @holdings[which_holdings].new_item(defaults.merge(opts))
  end

  # Create a bib record only.
  def create_bib
    visit BibEditorPage do |page|

      # TODO Implement support for MARC control lines & leader field

      # Enter all MARC lines in order.
      @bib.marc_lines.each_with_index do |marc_line,i|
        page.tag(i).when_present.set(marc_line.tag)
        page.indicator_1(i).when_present.set(marc_line.ind_1)
        page.indicator_2(i).when_present.set(marc_line.ind_2)
        page.subfield(i).when_present.set(marc_line.subfield)
        page.add_line(i) unless i == @bib.marc_lines.count
      end

      # Save the bib record.
      page.save
    end
  end

  # Create a holdings record only.
  # @note This method assumes that we're starting from the BibEditorPage.
  #   When invoking this method outside of initial bib creation, please retrieve
  #   the bib record through the lookup_bib method.
  #
  # Params:
  #   which         Fixnum          The index of the holdings record to enter.
  #                                 This is used to determine both the holdings
  #                                 record link to select on the screen and the
  #                                 object to select from the holdings array.
  def create_holdings(which = 0)
    holdings = @holdings[which]

    on HoldingsEditorPage do |page|
      if page.holdings_link(which).present?
        page.holdings_link(which).click
      else
        page.add_instance
      end

      page.location.when_present.set(holdings.location)
      page.call_number.when_present.set(holdings.call_number)
      page.call_number_type.when_present.select(/#{holdings.call_number_type}/)
      page.save
    end
  end


  # Create an item record only.
  # @note This method assumes that we're starting from the HoldingsEditorPage.
  #   When invoking this method outside of initial bib creation, please retrieve
  #   the bib record through the lookup_bib method, then open the relevant holdings
  #   record with the open_holdings method.
  #
  # Params:
  #   which_item        Fixnum          The index of the item record to enter.
  #                                     This is used to determine both the item
  #                                     record link to select on the screen and the
  #                                     object to select from the items array.
  #
  #   which_holdings    Fixnum          The index of the holdings record on which
  #                                     the item should reside.  This is used to determine
  #                                     the holdings record link to select on the screen.
  #
  def create_item(which_item = 0,which_holdings = 0)
    if which_item == 0
      open_item(which_item,which_holdings)
    else
      on HoldingsEditorPage do |page|
        # add the item and wait for the blank item editor page to appear
      end
    end

    item = @holdings[which_holdings].items[which_item]
    on ItemEditorPage do |page|
      page.item_type.when_present.select(/#{item.type}/)
      page.item_status.when_present.select(/#{item.status}/)
      page.barcode.when_present.set(item.barcode)
      page.save
      page.windows[-1].close if page.windows.count > 1
      page.windows[-1].use
    end
  end

  # Lookup a bib record.
  def lookup_bib
    visit WorkbenchPage do |page|
      page.document_type.when_present.fit 'Bibliographic'
      page.wait_until_loaded
      page.search_type.when_present.fit 'Search'
      page.wait_until_loaded
      page.search_for.when_present.fit @bib.title
      page.search_conditions.when_present.fit 'As a phrase'
      page.search_in_field.when_present.fit 'Title'
      page.add_line
      page.search_for(1).when_present.fit @bib.author
      page.search_conditions(1).when_present.fit 'As a phrase'
      page.search_in_field(1).when_present.fit 'Author'
      page.search
      expect(page.link_in_results?(@bib.title) && page.text_in_results?(@bib.author)).to be_truthy
    end
  end

  # Lookup a hldings record.
  def lookup_holdings(which=0)
    holdings = @holdings[which]
    visit WorkbenchPage do |page|
      page.document_type.when_present.fit 'Holdings'
      page.wait_until_loaded
      page.search_type.when_present.fit 'Search'
      page.wait_until_loaded
      page.search_for.when_present.fit holdings.call_number
      page.search_conditions.when_present.fit 'As a phrase'
      page.search_in_field.when_present.fit 'ANY'
      page.add_line
      page.search_for(1).when_present.fit holdings.location
      page.search_conditions(1).when_present.fit 'As a phrase'
      page.search_in_field(1).when_present.fit 'Location'
      page.search
      expect(page.text_in_results?(holdings.call_number) && page.text_in_results?(holdings.location)).to be_truthy
    end
  end

  # Lookup an item record.
  def lookup_item(which_holdings=0,which_item=0)
    item = @holdings[which_holdings].items[which_item]
    visit WorkbenchPage do |page|
      page.document_type.when_present.fit 'Item'
      page.wait_until_loaded
      page.search_type.when_present.fit 'Search'
      page.wait_until_loaded
      page.search_for.when_present.fit item.barcode
      page.search_conditions.when_present.fit 'As a phrase'
      page.search_in_field.when_present.fit 'Item Barcode'
      page.search
      expect(page.text_in_results?(item.barcode)).to be_truthy
    end
  end

  # Open a holdings record from the Bib Editor page.
  # Params:
  #   which       Fixnum          The 1-based number of the holdings record to open.
  def open_holdings(which = 1)
    on BibEditorPage do |page|
      page.holdings_link(which).when_present.click
    end
  end

  # Open an item record from the Holdings Editor page.
  # Params:
  #   which_item        Fixnum      The index of the item record to open.
  #   which_holdings    Fixnum      The index of the holdings record to open.
  def open_item(which_item = 0,which_holdings = 0)
    on HoldingsEditorPage do |page|
      item_link = page.item_link(which_holdings,which_item)
      page.expand_holdings(which_holdings)
      item_link.when_present.click
      page.windows[-1].use if page.windows.count > 1
    end
  end

  def to_mrc
    @bib.to_marc
  end
  alias_method(:to_marc,:to_mrc)

  # Open the loan screen to check out an item to a patron.
  def loan_to(patron,which_holdings = 0,which_item = 0)
    item = @holdings[which_holdings].items[which_item]
    desk = @holdings[which_holdings].circulation_desk
    open_loan_page
    on LoanPage do |page|
      select_circ_desk(page,desk)
      page.patron_barcode.when_present.enter(patron.barcode)
      page.wait_until_loaded
      page.item_barcode.when_present.enter(item.barcode)
      page.wait_until_loaded
      page.confirm_loan if page.loan_popup?
      expect(page.checked_out_items?).to be_truthy
      expect(page.barcode_in_items?(item.barcode)).to be_truthy
      expect(page.text_in_items?(@bib.title)).to be_truthy
      expect(page.text_in_items?(@bib.author)).to be_truthy
    end
  end

  # Open the return screen to return an item in loaned status.
  def return(which_holdings = 0,which_item = 0)
    item = @holdings[which_holdings].items[which_item]
    desk = @holdings[which_holdings].circulation_desk
    open_loan_page
    on LoanPage do |page|
      page.return_page
    end
    on ReturnPage do |page|
      select_circ_desk(page,desk)
      page.item_barcode.enter(item.barcode)
      page.wait_until_loaded
      expect(page.items_returned?).to be_truthy
      expect(page.barcode_in_items?(item.barcode)).to be_truthy
      expect(page.text_in_items?(@bib.title)).to be_truthy
      expect(page.text_in_items?(@bib.author)).to be_truthy
    end
  end

  private

  # Navigate to the Loan page from the Portal.
  def open_loan_page
    visit PortalPage do |page|
      page.deliver_tab.when_present.click
      page.link(:text => /Loan/i).when_present.click
      page.wait_until_loaded
    end
  end

  def select_circ_desk(page,desk)
    unless page.circulation_desk.when_present.get_selected_text == desk.code
      page.circulation_desk.wait_until_present
      page.circulation_desk.fit(desk.code)
      page.wait_until_loaded
      page.confirm_desk_change if page.desk_change_popup?
    end
  end
end

class ResourceCollection < CollectionsFactory
  contains Resource
end
