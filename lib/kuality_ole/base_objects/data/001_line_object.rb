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

# A data object for handling repeatable lines of elements.
#   (e.g., Addresses on Patron, Line Items on PURAP Documents)
class LineObject < DataFactory

  # The ordinal (0-based) of the line's position on the page.
  #   This attribute also serves to identify the object's position
  #   in a collection.
  attr_accessor :index

  # The LineCollection instance to which this line belongs.
  #   This attribute is particularly useful if you have line objects on a page
  #   where new lines are added at the top of the group, rather than the bottom,
  #   (i.e., more like an #unshift than a #push).  In this case, you can use
  #   @collection to iterate through the collection itself when necessary
  #   (e.g., for expanding details on expandable lines that start out contracted).
  attr_accessor :collection
end