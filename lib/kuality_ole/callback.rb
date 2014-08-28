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

# Create an object that allows a block to perform dynamic callbacks.
#
#   This technique is courtesy of Matt Sears and Edward Anderson:
#     http://www.mattsears.com/articles/2011/11/27/ruby-blocks-as-dynamic-callbacks
#     https://gist.github.com/nilbus/6385142
#
#   Bodhi provides an excellent walkthrough of this technique at:
#     http://techscursion.com/2011/11/turning-callbacks-inside-out
#
class Callback
  def initialize(block)
    block.call(self)
  end
  
  def callback(message, *args)
    raise KualityOle::Error,"Callback not defined.\n(Given: #{message})" if callbacks[message].nil?
    callbacks[message].call(*args)
  end
  
  def method_missing(message, *args, &block)
    block ? callbacks[message] = block : super
    self
  end
  
  private
  
  def callbacks
    @callbacks ||= {}
  end
end
