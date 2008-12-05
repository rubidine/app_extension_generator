#
# This file is only loaded if you have uncommed it out in the test helper.
#
module FixtureReplacement
  attributes_for :my_model do |m|
    m.attr1 = 'value1'
    m.attr2 = String.random
  end
end
