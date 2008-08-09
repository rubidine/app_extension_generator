namespace :<%= file_name %> do

  desc "Run migrations for the <%= class_name %> Extension"
  task :migrate do
    require 'environment'
    ActiveRecord::Base.establish_connection
    require File.join(File.dirname(__FILE__), '..', 'ext_lib', 'plugin_migrator')
    ActiveRecord::PluginMigrator.migrate(File.join(File.dirname(__FILE__), '..', 'db', 'migrate'), ENV['VERSION'] ? ENV['VERSION'].to_i : nil)
  end

  desc 'Test the <%= class_name %> Extension.'
  Rake::TestTask.new(:test) do |t|
    require 'environment'
    t.ruby_opts << "-r#{RAILS_ROOT}/test/test_helper"
    t.libs << File.join(File.dirname(__FILE__), '..', 'lib')
    t.pattern = File.join(File.dirname(__FILE__), '..', 'test/**/*_test.rb')
    t.verbose = true
  end

end
