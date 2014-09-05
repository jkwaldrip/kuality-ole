### 
https://jira.kuali.org/browse/OLE-6981
https://jira.kuali.org/browse/OLE-6917
https://jira.kuali.org/browse/OLE-6842

- Handle Resources as a Collection
    - Resource Group holds resources in a CollectionsFactory collection.
    - CollectionsFactory now allows #add_only, which adds constituents without
      invoking their #create methods.
- Made fixes to Marc record creation when writing to file.

### 0.1.0 - 2014/08/28
https://jira.kuali.org/browse/OLE-6841
https://jira.kuali.org/browse/OLE-6905
https://jira.kuali.org/browse/OLE-6904
https://jira.kuali.org/browse/OLE-6926

- Created localization options for Kuality OLE, configured in config/institutional/localization.yml.
- Split gem_ext into tf_ext (TestFactory extensions) and watir_ext (Watir-Webdriver extensions).
- TestFactory Extensions
    - Data Object
        - Added #autofill and #autofill_params to better support line_elements/values/actions.
            - Both methods look for instance variables ONLY, they do not parse opts.
    - Page Object
        - Implemented dynamic callbacks to provide multiple, callback-based definitions for line objects.
            - See #line_element and lib/kuality_ole/callbacks.rb
        - Implemented #wait_until_loaded/#wait_till_loaded on Page classes.
            - Calls wait_for_ajax on page to ensure all ajax activity has stopped.
            - Waits for all elements registered (with .wait_on in page definition) to be present.
- Watir-Webdriver Extensions
    - Added #get_selected_text & #get_selected_value.
    - Modified #select_by to wait for value to exist before attempting to select it.
    - Modified #fit (from TestFactory gem extensions) to try selecting by value or by text.
- Updated Marc-related pages to use proper TestFactory element naming conventions (i.e., no field, selector, &c.)
- Now requires TestFactory 0.5.1, for improved #fit support.
- Fixed definitions of tabs on BasePage, registered all tabs with .wait_on in PortalPage.
- Created Patron data object.
- Created Patron pages.
- Separated Helpers module into Helpers (for use in Cucumber as well as Data/Info objects) & DataHelpers (for Data & Info objects).
- Renamed MarcRecord to Resource, MarcGroup to ResourceGroup.
- Restricted default barcode length to 13 characters total (OLEQA + 6-8 numeric characters).
- Moved MarcEditorPage from base_objects/pages to page_objects/describe/000_marc_editor_page.

## 0.0.3 - 2014/08/01
https://jira.kuali.org/browse/OLE-6814

- Moved spec/data & spec/info to spec/data_objects & spec/info_objects.
- Created spec/data for RSpec test data files.
- Moved opts_to_vars from InfoObject to Helpers for use on Data Objects.
- MarcBib.to_mrc now returns the Ruby-Marc formatted record instead of true.
- MarcRecord now has a .to_mrc method which returns the contained bib as a Ruby-Marc record.
- Created MarcGroup class to serve as a container for read/write of multiple records to/from
  a Marc (.mrc) file.
  - Records can be added manually and written to a file.
  - Records can be instantiated from a file by giving the filepath.
- Moved MarcRecord class to an 000_ prefix to allow loading before MarcGroup.

## 0.0.2 - 2014/07/31
https://jira.kuali.org/browse/OLE-6813

- Fixed User steps error in RSpec login expectation, was 'be_truthy' (2.99), now 'be_true' (2.14)
- Created method to allow MarcDataLines to be created from Ruby-Marc data fields.
- Created method to allow MarcBibs to be created from Ruby-Marc records.
- Refactored MarcBib to depend only on MarcDataLines, not :title and :author options.
- Created method to allow Marc Data Lines to be transformed into Ruby-Marc fields.
- Created method to allow Marc Bibs to be transformed into Ruby-Marc records.
- Created method to allow Marc Bibs to be written to a .mrc file via Ruby-Marc.
- Created placeholder classfile for MarcRecords class, intended to handle multiple records
  for import/export file-conversion purposes.

## 0.0.1 - 2014/07/29

- Initial CHANGELOG commit.
