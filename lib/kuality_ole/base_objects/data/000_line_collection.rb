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

# A collection of data objects meant to handle a group of LineObjects.
#
# @note This class does not replace CollectionsFactory!
#   This class functions similarly to CollectionsFactory in TestFactory.
#   When creating subclasses of this object, add Line to the end
#   of the class name, rather than Collection, in order to preserve
#   the distinction between LineCollections and normal Collections.
#
# @note
#   A Line Collection for a given Line Object will generally be
#   defined at the end of the Line Object's class file.
#
class LineCollection < Array
  include Foundry

  def initialize(browser)
    @browser = browser
  end

  def self.contains klas
    # The add method can be called just like in CollectionsFactory.
    # - Optionally pass a symbol as the first argument to determine whether
    #   the line being added should be pushed or unshifted to the collection.
    # - All Hash k/v pairs will be swept up into opts.
    # - The default method is :push.
    #
    define_method 'add' do |*args|
      how = args[0].is_a?(Symbol) ? args[0] : :push
      opts = args[-1].is_a?(Hash) ? args[-1] : {}
      line = klas.new @browser,opts
      case how
      when :push
        self.push line
      when :unshift
        self.unshift line
      end
      line.create
    end
  end

  # Add a line to the end of the collection.
  alias_method(:ary_push,:push)
  def push line
    line.index      = count
    line.collection = self
    ary_push line
  end
  alias_method(:<<,:push)

  # Add a line to the beginning of the collection.
  alias_method(:ary_unshift,:unshift)
  def unshift line
    line.index      = 0
    line.collection = self
    ary_unshift line
    reindex!
  end

  # Delete a line at the given index.
  alias_method(:ary_delete_at,:delete_at)
  def delete_at i
    self[i].delete
    ary_delete_at i
    reindex!
  end

  # Update all line indices.
  def reindex!
    each_with_index do |line,ind|
      line.index = ind
    end
  end

end
