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
