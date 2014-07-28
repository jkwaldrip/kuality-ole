#!/usr/bin/sh ruby

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

dir = File.expand_path(File.dirname(__FILE__))
$:.unshift(dir) unless $:.include?(dir)

# Gems
require 'chronic'
require 'headless'
require 'marc'
require 'numerizer'
require 'rspec/expectations'
require 'rspec/matchers'
require 'watir-webdriver'
require 'test-factory'
require 'selenium/webdriver/remote/http/persistent'

# Ruby Modules
require 'yaml'
require 'fileutils'
require 'timeout'

module KualityOle
  # Load settings from config/options.yml
  @options = YAML.load_file('config/options.yml')
  # Override settings from config/options.yml with ENV values if found
  #
  #   OLE_URL                   :url                    OLE installation
  #   OLE_DOCSTORE_URL          :docstore_url           OLE installation's Document Store
  #   OLE_WAIT                  :default_wait           Watir-Webdriver's default timeout value
  #   --                        :headless?              Run tests headlessly in XVFB?
  #   --                        :development?           Run tests against a development installation?
  env_options = {
      :url          => ENV['OLE_URL'],
      :docstore_url => ENV['OLE_DOCSTORE_URL'],
      :default_wait => ENV['OLE_WAIT']
  }.delete_if {|k,v| v.nil?}    # Do not create a key if the value is not found.
  @options.merge!(env_options)
  @url,@docstore_url = @options[:url],@options[:docstore_url]

  class << self
    # Make the options hash readable.
    attr_reader :options

    # Make the URLs from the options hash readable.
    attr_reader :url,:docstore_url

    # Are the tests running against a development environment.
    def development?
      @options[:development?]
    end
  end

  # Set internal error class.
  class Error < StandardError
  end

  # Set the interval (in seconds) for spin assertions and other loops.
  Interval = 1


  # Load internal classes/modules.
  Dir['lib/kuality_ole/*.rb'].sort.each {|file| require file}
  Dir['lib/kuality_ole/base_objects/**/*.rb'].sort.each {|file| require file}
  Dir['lib/kuality_ole/page_objects/**/*.rb'].sort.each {|file| require file}
  Dir['lib/kuality_ole/data_objects/**/*.rb'].sort.each {|file| require file}

  # Add directories if they do not already exist.
  ['screenshots','data','data/downloads','data/uploads'].each do |dir|
    FileUtils::mkdir(dir) unless File.directory?(dir)
  end

  # -- BROWSER SECTION --
  # Set the default timeout on Watir-Webdriver
  Watir.default_timeout = @options[:default_wait]

  class << self
    # Start the browser and return the browser instance.
    def start_browser
      timeout = Time.now + 300
      c = 0
      begin
        browser = Watir::Browser.new :firefox
        break
      rescue
        c += 1
        puts "Browser connection not made. Trying again in 5 seconds. (Attempt #{c})"
        sleep 5
      end while Time.now < timeout
      raise KualityOle::Error,"Browser connection not made after 5 minutes." unless browser.is_a?(Watir::Browser)
      browser
    end
    alias_method(:browser_start,:start_browser)

  end
end
