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

require 'cucumber/rake/task'
require 'kuality_ole/version'
require 'yaml'
require 'rspec/core/rake_task'

desc 'Display the current version number'
task :version do
  puts "Version #{KualityOle::Version}"
end

desc 'Remove all test data and screenshots'
task :clean_all do
  files = Dir['data/downloads/mrc/*','data/uploads/mrc/*','screenshots/*'].sort
  if files.empty?
    puts 'No files found.'
  else
    files.each {|file| File.delete file}
    puts "#{files.count} files deleted."
  end
end

desc 'Show options in config/options.yml'
task :show_config do
  options     = YAML.load_file('config/options.yml')
  options.each do |k,v|
    puts "#{k.to_s.ljust(20)}:  #{v}"
  end
end

desc 'Set options in config/options.yml'
task :configurator do
  options     = YAML.load_file('config/options.yml')
  options.each do |k,v|
    puts "#{k.to_s.ljust(20)}:  #{v}"
    puts "... (k)eep or (c)hange? [k|c]"
    ans = STDIN.gets.chomp
    if ans =~ /[Cc]/
      puts "Enter new value:"
      new_val    = STDIN.gets.chomp
      if v.is_a?(TrueClass) || v.is_a?(FalseClass)
        new_val.match(/^[Tt]/) ? new_val = true : new_val = false
      else
        new_val = new_val.to_i unless new_val.to_i == 0
      end
      options[k] = new_val
      puts "#{k.to_s.ljust(20)} updated to:  #{new_val}"
    end
  end
  File.write('config/options.yml',options.to_yaml) 
end

desc 'Run development specs (not regression tests).'
RSpec::Core::RakeTask.new(:specs) do |task|
  task.rspec_opts = '-r spec_helper.rb'
end
