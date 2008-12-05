# Copyright (c) 2008 Todd Willey <todd@rubidine.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

class AppExtensionGenerator < PluginGenerator

  def manifest_with_app_ext
    manifest_without_app_ext
    record do |m|
      m.directory "#{plugin_path}/public"
      m.directory "#{plugin_path}/public/images"
      m.directory "#{plugin_path}/public/javascripts"
      m.directory "#{plugin_path}/public/stylesheets"

      m.directory "#{plugin_path}/ext_lib"

      m.directory "#{plugin_path}/db"
      m.directory "#{plugin_path}/db/migrate"

      m.directory "#{plugin_path}/app"
      m.directory "#{plugin_path}/app/models"
      m.directory "#{plugin_path}/app/views"
      m.directory "#{plugin_path}/app/controllers"
      m.directory "#{plugin_path}/app/helpers"

      m.template 'plugin_migrator.rb', "#{plugin_path}/ext_lib/#{file_name}_migrator.rb"
      m.template 'ext_init.rb', "#{plugin_path}/ext_lib/init.rb"
      m.template 'dependency_extension.rb', "#{plugin_path}/ext_lib/#{file_name}_dependencies.rb"
      m.template 'routing_extension.rb', "#{plugin_path}/ext_lib/#{file_name}_routing_extension.rb"

      m.template 'exemplar_data.rb', "#{plugin_path}/test/exemplar_data.rb"
    end
  end

  alias_method_chain :manifest, :app_ext

  private

  # overwrite this so we don't have to copy in the old manifest function body
  def record
    @manifest ||= Rails::Generator::Manifest.new(self)
    yield @manifest
    @manifest
  end
end
