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

# An OLE non-Patron System User with a login.
#
# @note User configuration info is loaded from/written to:
#   config/institutional/users.yml
class User < DataFactory
  
  attr_reader :username,:role,:name

  # Enter information for a new user, or select an existing user by username.
  # @note Usage:
  #   This class can be invoked with only the username of an existing user
  #   or an existing role name and :lookup_role => true to return an existing user.
  #
  #   TODO This class can alternately be invoked with a new username and additional user data
  #   in order to create a new user in the target system and save the user to the users file.
  #
  # Options:
  #   :username       String            The user's unique OLE user ID.
  #   :role           String            The user's general role.
  #   :name           String            The user's full name, if any.
  #   :save?          Boolean           Save the user if new?
  #                                     (Ignored if a matching username is found.)
  #   :lookup_role?   Boolean           Lookup a given user role.
  #                                     (Other parameters will be ignored if this is true.)
  #
  def initialize(browser,opts={})
    @browser = browser

    defaults = {
      :username => 'ole-quickstart',   # Set this to your local default username.
      :save?    => false
    }
    @options = defaults.merge(opts)

    if user_exists?(:how => 'username',:which => @options[:username]) && ! @options[:lookup_role?]
      retrieve_user(:how => 'username',:which => @options[:username])
    elsif @options[:lookup_role?]
      raise KualityOle::Error,"Role not found.\n(Given: #{@options[:role]})" unless user_exists?(:how => 'role',:which => @options[:role])
      retrieve_user(:how => 'role',:which => @options[:role])
    else create_new(opts) end

    options = @options.delete_if {|k| k.to_s[/\?$/]}
    set_options(options)

    requires :username
  end

  def open_portal
    visit PortalPage
  end

  def login
    on LoginPage do |page|
      page.login(@username)
    end
  end

  def logout
    on LoginPage do |page|
      page.logout
    end
  end

  def logged_in?
    on LoginPage do |page|
      return page.logged_in_as == @username || page.impersonating == @username
    end
  end

  private
    
  # Check if a user exists in the users file. (See #lookup for parameters.)
  def user_exists?(opts)
    lookup(opts).nil? ? false : true
  end

  # Destructively merge 
  def retrieve_user(opts)
    @options.merge!(lookup(opts))
  end

  # Returns a user info hash based on the first matched value from the users file.
  #
  # Options
  #   :how        String      The key to search on.
  #   :which      String      The value to find.
  def lookup(opts={})
    users = YAML.load_file('config/institutional/users.yml')
    case opts[:how]
    when 'username'
      users.select {|user| user[:username] == opts[:which].downcase}[0]
    when 'role'
      users.select {|user| user[:role] == opts[:which].downcase}[0]
    else
      raise KualityOle::Error,"User search method not supported.\n(Given: #{opts[:how]})"
    end
  end

  # Create a new user.
  # - Only used if the given username or role is not found in the users file.
  def create(user_info)
    # TODO Enter workflow to create a new user in the OLE system.
    save_user(user_info) if user_info[:save?]
  end

  # Add a user info hash to the users file.
  def save_user(user_info)
    users = YAML.load_file('config/institutional/users.yml')
    users << user_info
    File.write('config/institutional/users.yml',users.to_yaml)
  end
end
