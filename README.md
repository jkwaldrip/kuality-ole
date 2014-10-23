# Kuality OLE

Kuality OLE is a TestFactory-based testing application for the Kuali Open Library Environment.
It seeks to adhere to the TestFactory design pattern wherever possible.

## Usage

In the upper-level directory for this repository, run all available tests by invoking Cucumber:

    $ cucumber

## RSPEC

RSpec is used in two ways within this project:

1.  To provide a language of expectations used within both data objects and Cucumber step files.
2.  To provide internal testing for behavior-driven development of this project.

### Language of Expectations

RSpec expectations are included as a Cucumber World (module) in [features/support/env.rb](features/support/env.rb).
Expectations will appear in [data objects](lib/kuality_ole/data_objects/), which comprise the control
layer for [page objects](lib/kuality_ole/page_objects/).  Data objects are abstractions representing
a particular set of data needed to complete a workflow.  RSpec expectations in data objects provide a
means of reporting whether the workflow enacted by a data object is successful by raising exceptions
whenever expectations are not met.

### Behavior-Driven Development

Full-featured RSpec tests are maintained in the [spec](spec/) directory.  Behavioral specs are written
during the development of both [info objects](lib/kuality_ole/base_objects/info/) and [data objects](lib/kuality_ole/base_objects/data/).
Key features and functions of an info or data object should be described in a spec before the object
is created.

To ensure that all specs are passing, invoke RSpec from the upper-level directory of this repository:

    $ rspec


#### BDD Guidelines

- Specs should not rely on [institutional data](config/institutional/) unless it is absolutely necessary.
- Specs should not initiate any interaction between the testing application and the OLE application itself.
- All specs must pass before a new data or info object is committed.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/tfsandbox/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
