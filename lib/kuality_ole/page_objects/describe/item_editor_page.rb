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

# The OLE Library System Item Editor page.
class ItemEditorPage < MarcEditorPage

      # Holdings Location/Call Number Information
      value(:holdings_location)                           {|b| b.iframeportlet.span(:id => "OleHoldingLocationLevelName_control").value}
      value(:holdings_prefix)                             {|b| b.iframeportlet.span(:id => "OleHoldingCallNumberPrefix_control").value}
      value(:holdings_shelving_order)                     {|b| b.iframeportlet.span(:id => "OleHoldingShelvingOrder_control").value}
      value(:holdings_call_number)                        {|b| b.iframeportlet.span(:id => "OleHoldingCallNumber_control").value}
      value(:holdings_call_number_type)                   {|b| b.iframeportlet.span(:id => "OleHoldingShelvingScheme_control").value}
      # Item Location/Call Number Information
      element(:location_field)                            {|b| b.iframeportlet.text_field(:id => "OleItemLocationLevelName_control")}
      element(:prefix_field)                              {|b| b.iframeportlet.text_field(:id => "OleItemCallNumberPrefix_control")}
      element(:shelving_order_field)                      {|b| b.iframeportlet.text_field(:id => "OleItemShelvingOrder_control")}
      element(:call_number_field)                         {|b| b.iframeportlet.text_field(:id => "OleItemCallNumber_control")}
      element(:call_number_type_selector)                 {|b| b.iframeportlet.select_list(:id => "OleItemShelvingScheme_control")}
      element(:browse_button)                             {|b| b.iframeportlet.button(:id => "callNumberItemBrowseLink")}
      # Item Information
      element(:id_field)                                  {|b| b.iframeportlet.text_field(:id => "oleItemIdentifier_ID_control")}
      element(:barcode_field)                             {|b| b.iframeportlet.text_field(:id => "oleItemAccessInformationBarcode_control")}
      element(:barcode_arsl_field)                        {|b| b.iframeportlet.text_field(:id => "oleItemBarcodeARSL_control")}
      element(:former_identifiers_field)                  {|b| b.iframeportlet.text_field(:id => "oleItemFormerIdentifier_control")}
      element(:statistical_searching_codes_selector)      {|b| b.iframeportlet.select_list(:id => "oleItemStatisticalSearchingCodes_control")}
      element(:temp_item_type_selector)                   {|b| b.iframeportlet.select_list(:id => "oleItemTemporaryItemType_control")}
      element(:enumeration_field)                         {|b| b.iframeportlet.text_field(:id => "oleItemEnumeration_control")}
      element(:chronology_field)                          {|b| b.iframeportlet.text_field(:id => "oleItemChronology_control")}
      element(:copy_number_field)                         {|b| b.iframeportlet.text_field(:id => "oleItemCopyNumber_control")}
      element(:access_info_uri_field)                     {|b| b.iframeportlet.text_field(:id => "oleItemAccessInformationURI_control")}
      element(:item_type_selector)                        {|b| b.iframeportlet.select_list(:id => "oleItemItemType_control")}
      element(:number_of_pieces_field)                    {|b| b.iframeportlet.select_list(:id => "oleItemNumberOfPiece_control")}
      # Acquisition Information
      element(:po_line_item_id_field)                     {|b| b.iframeportlet.text_field(:id => "oleItemPoID_control")}
      element(:vendor_line_item_id_field)                 {|b| b.iframeportlet.text_field(:id => "oleItemVendorLineItemID_control")}
      element(:fund_field)                                {|b| b.iframeportlet.text_field(:id => "oleItemFund_control")}
      element(:price_field)                               {|b| b.iframeportlet.text_field(:id => "oleItemPrice_control")}
      element(:donor_public_display_field)                {|b| b.iframeportlet.text_field(:id => "oleItemDonorPublicDisplay_control")}
      element(:donor_note_field)                          {|b| b.iframeportlet.text_field(:id => "oleItemDonorNote_control")}
      # Circulation Information
      element(:item_status_selector)                      {|b| b.iframeportlet.select_list(:id => "oleItemStatus_control")}
      element(:checkin_note_field)                        {|b| b.iframeportlet.text_field(:id => "oleItemCheckinNote_control")}
      element(:item_effective_status_date)                {|b| b.iframeportlet.text_field(:id => "oleItemStatusEffectiveDate_control")}
      element(:fast_add_checkbox)                         {|b| b.iframeportlet.checkbox(:id => "oleItemFastAdd_control")}
      element(:staff_only_checkbox)                       {|b| b.iframeportlet.checkbox(:id => "oleItemStaffOnly_control")}
      # Extended Information
      element(:high_density_storage_field)                {|b| b.iframeportlet.text_field(:id => "oleItemHighDensityStorage_control")}

      # TODO Add Readonly elements.
end
