# coding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kuality_ole/version'

Gem::Specification.new do |spec|
  spec.name          = "kuality-ole"
  spec.version       = KualityOle::Version
  spec.authors       = ["Jain Waldrip"]
  spec.email         = ["jkwaldri@iu.edu"]
  spec.summary       = %q{TestFactory tests for Kuali OLE}
  spec.description   = %q{A Cucumber-driven test application for the Kuali Open Library Environment}
  spec.homepage      = ""
  spec.license       = "ECLv2"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "headless"                    # XVFB Session-Handling Gem
  spec.add_dependency "rspec","~> 3.0"           # Provides expectation language
  spec.add_dependency "net-http-persistent"         # Stabilizes HTTP connections
  spec.add_dependency "chronic"                     # Provides Englishy date-mapping
  spec.add_dependency "numerizer"                   # Provides Englishy number support
  spec.add_dependency "marc"                        # I/O for MARC-format Library Records
  spec.add_dependency "cucumber"                    # Provides the main testing 
  spec.add_dependency "test-factory",">= 0.5.1"     # Provides LFM for Watir-Webdriver

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
