# 'directory' is defined in rails plugin loading, and since we are eval'd
# instead of required, we get it here.  But radiant seems to require or load
# instead of eval, so work with it.  Also it can be defined as a function during
# migrations for some reason.
unless defined?(directory) == 'local-variable'
  directory = File.dirname(__FILE__)
end

# Load the extension mojo that hacks into the rails base classes.
require File.join(directory, 'ext_lib', 'init.rb')

# define some routes
#
# ActionController::Routing::Routes.define_<%= file_name %>_routes do |map|
#   map.connect '<%= file_name %>/:action/:id', :controller=>'<%= file_name %>'
# end

# Monkey patch into the core classes.
#
# There are two ways to do this, if you are patching into a core class
# like ActiveRecord::Base then you can include a class defined by a file
# in this plugin's lib directory
#
# ActiveRecord::Base.send :include, MyClassInLibDirectory
#
# If you are patching a class in the current application, such as a specific
# model that will get reloaded by the dependencies mechanism (in development
# mode) you will need your extension to be reloaded each time the application
# is reset, so use the hook we provide for you.
#
Dependencies.register_<%= file_name %>_extension do
  # to add relationships, validations, etc
  # SomeModel.send :has_many, :my_model

  # to add new methods to instances of a class
  # define a module in lib/extensions/some_model_<%= file_name %>_extension
  # SomeModel.send :include, SomeModel<%= class_name %>Extension
  # SomeModel.new.my_mixed_in_method

  # to add new class methods
  # define a module in lib/extensions/some_model_<%= file_name %>_class_extension
  # SomeModel.send :extend, SomeModel<%= class_name %>ClassExtension
  # SomeModel.my_mixed_in_method
end
