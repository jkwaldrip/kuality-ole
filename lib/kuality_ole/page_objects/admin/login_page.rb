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

# A page for handling logins.
class LoginPage < BasePage

  # TODO Create non-development elements & actions.
  # TODO Create non-development login URL handling.

  element(:login_field)                 {|b| b.text_field(:name => 'backdoorId')}
  element(:login_button)                {|b| b.input(:class => 'go',:value => 'Login')}
  element(:logout_button)               {|b| b.input(:class => 'go',:value => 'Logout')}

  # Set up backdoorlogin elements if testing against a development environment.
  if KualityOle.development?
    element(:login_confirmation)        {|b| b.div(:id => 'login-info').strong(:text => /Impersonating User\:/)}
    value(:logged_in_as)                {|b| b.div(:id => 'login-info').strong(:index => 0).text.match(/(?:\:\s)([\w\-\_]+)/)[1]}
    value(:impersonating)               {|b| elmnt = b.div(:id => 'login-info').strong(:index => 1)
                                        elmnt.present? ?
                                        elmnt.text.match(/(?:\:\s)([\w\-\_]+)/)[1] :
                                        ''
    }


    # Log in with a given username; returns (true|false) depending upon success.
    action(:login)                        {|who,b| b.login_field.when_present.set(who)
                                          b.login_button.click
                                          return false unless b.login_confirmation.wait_until_present
                                          b.impersonating == who ? true : false
    }
    # Log out; returns (true|false) depending upon success.
    action(:logout)                       {|b| b.logout_button.when_present.click
                                          b.login_confirmation.present? ? false : true
    }

  end

end
