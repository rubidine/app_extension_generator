# if you are wanting to do full unit / functional / integration tests
# uncomment the next three lines
#ENV['RAILS_ENV'] = 'test'
#require File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'config', 'environment')
#require 'test_help'

require 'test/unit'

class <%= class_name %>Test < Test::Unit::TestCase
  # Replace this with your real tests.
  def test_this_plugin
    flunk
  end
end
