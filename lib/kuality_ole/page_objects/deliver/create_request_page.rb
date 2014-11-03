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

class CreateRequestPage < KradEdocPage


  #--Type of User--
  element(:user_type)                 {|b| b.iframeportlet.select_list(:id => 'selectRequestBorrower-MaintenanceView-requestCreators_control')}

  #--Type of Request--
  element(:request_type)              {|b| b.iframeportlet.select_list(:id => 'selectRequestBorrower-MaintenanceView-requestTypeIds_control')}

  #--Borrower Details--
  element(:borrower_barcode)          {|b| b.iframeportlet.text_field(:id => 'selectRequestBorrower-MaintenanceView-borrowerBarcodes_control')}
  action(:borrower_search)            {|b| b.iframeportlet.fieldset(:id => 'selectRequestBorrower-MaintenanceView-borrowerBarcodes_fieldset').input(:index=>1, :class=> 'uif-actionImage').when_present.click}
  element(:borrower_name)             {|b| b.iframeportlet.text_field(:id => 'selectRequestBorrower-MaintenanceView-borrowerNames_control')}

  #--Recall/Delivery Request & Recall/Hold Request--
  element(:recall_item_barcode)       {|b| b.iframeportlet.text_field(:id => 'RecallRequest-itemId_control')}
  action(:recall_item_search)         {|b| b.iframeportlet.fieldset(:id => 'RecallRequest-itemId_fieldset').input(:index => 1, :class=> 'uif-actionImage').when_present.click}

  #--Hold/Delivery Request & Hold/Hold Request--
  element(:hold_item_barcode)         {|b| b.iframeportlet.text_field(:id => 'OnholdRequest-itemId_control')}
  action(:hold_item_search)           {|b| b.iframeportlet.fieldset(:id => 'OnholdRequest-itemId_fieldset').input(:index => 1, :class=> 'uif-actionImage').when_present.click}

  #--Page/Delivery Request & Page/Hold Request--
  element(:page_item_barcode)         {|b| b.iframeportlet.text_field(:id => 'PageRequest-itemId_control')}
  action(:page_item_search)           {|b| b.iframeportlet.fieldset(:id => 'PageRequest-itemId_fieldset').input(:index => 1, :class=> 'uif-actionImage').when_present.click}

  #--Copy Request--
  element(:copy_item_barcode)         {|b| b.iframeportlet.text_field(:id => 'CopyRequest-itemId_control')}
  action(:copy_item_search)           {|b| b.iframeportlet.fieldset(:id => 'CopyRequest-itemId_fieldset').input(:index => 1, :class=> 'uif-actionImage').when_present.click}

  #--In Transit Request--
  element(:transit_item_barcode)      {|b| b.iframeportlet.text_field(:id => 'TransitRequest-itemId_control')}
  action(:transit_item_search)        {|b| b.iframeportlet.fieldset(:id => 'TransitRequest-itemId_fieldset').input(:index => 1, :class=> 'uif-actionImage').when_present.click}

  #--ASR Request--
  element(:asr_item_barcode)          {|b| b.iframeportlet.text_field(:id => 'OnholdRequest-itemId_control')}
  action(:asr_item_search)            {|b| b.iframeportlet.fieldset(:id => 'OnholdRequest-itemId_fieldset').input(:index => 1, :class=> 'uif-actionImage').when_present.click}

  #--Item Information--
  value(:item_title)                  {|b| b.iframeportlet.td.div(:data_label => 'Title').span(:class => 'uif-readOnlyContent')}
  value(:item_author)                 {|b| b.iframeportlet.td.div(:data_label => 'Item Author').span(:class => 'uif-readOnlyContent')}
  value(:item_location)               {|b| b.iframeportlet.td.div(:data_label => 'Shelving Location').span(:class => 'uif_readOnlyContent')}
  value(:item_call_number)            {|b| b.iframeportlet.td.div(:data_label => 'Call Number').span(:class => 'uif_readOnlyContent')}
  value(:item_copy_number)            {|b| b.iframeportlet.td.div(:data_label => 'Copy Number').span(:class => 'uif_readOnlyContent')}

  #--Patron Queue Position--
  value(:patron_queue_position)       {|b| b.iframeportlet.td.div(:data_label => 'Patron Queue Position').span(:class => 'uif_readOnlyContent')}

  #-- Pickup location--
  element(:pickup_location)           {|b| b.iframeportlet.select_list(:id => 'recallRequest-MaintenanceView-pickupLocation_control')}

  #--Circulation Location--
  element(:circulation_location)      {|b| b.iframeportlet.select_list(:id => 'inTransitRequest-circulationLocationId_control')}

  #--Create & Expiry Date--
  value(:create_date)                 {|b| b.iframeportlet.td.div(:data_label => 'Create Date').span(:class => 'uif_readOnlyContent')}
  value(:request_expiry_date)         {|b| b.iframeportlet.td.div(:data_label => 'Request Expiry Date').span(:class => 'uif_readOnlyContent')}

  #--Recall Notice Sent Date--
  value(:recall_notice_sent_date)     {|b| b.iframeportlet.td.div(:data_label => 'Recall Notice Sent Date').span(:class => 'uif_readOnlyContent')}

  #--OnHold Notice Sent Date--
  value(:hold_notice_sent_date)       {|b| b.iframeportlet.td.div(:data_label => 'OnHold Notice Sent Date').span(:class => 'uif_readOnlyContent')}

  #--Pages--
  element(:pages)                     {|b| b.iframeportlet.text_field(:id => 'copyRequest-contentDescription_control')}

  #--Copy Format--
  element(:copy_format)               {|b| b.iframeportlet.text_field(:id => 'copyRequest-copyFormat_control')}

  #--Checkin Note--
  element(:checkin_note)              {|b| b.iframeportlet.text_field(:id => 'inTransitRequest-checkInNote_control')}

  #--Submit Button--

  #--Save Button--

  #--Back Button--

  #--Cancel Button--

  # Ad Hoc Recipients, Route Log
end