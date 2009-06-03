# load Dispatcher if not present yet
unless defined?(ActionController) and defined?(ActionController::Dispatcher)
  require 'action_controller/dispatcher'
end

require File.join(File.dirname(__FILE__), '<%= file_name %>_dependencies')

# Views will also look here in the plugin.
# We use prepend_* to put this directory as a high priority, ahead of any previously loaded plugins.
# That way if you are following another plugin, but providing specific overrides they can take effect.
# If you want these to be lower priority, use append_ instead of prepend_.
#
# Google "Evil Twin Plugin" on errtheblog for more info.
ActionController::Base.prepend_view_path File.join(File.dirname(__FILE__), '..', 'app', 'views')

# copy in assets
if File.directory?(File.join(File.dirname(__FILE__), '..', 'public'))
  require 'fileutils'
  ['javascripts', 'stylesheets', 'images'].each do |type|
    p_path = File.join(File.dirname(__FILE__), '..', 'public', type)
    next if Dir[File.join(p_path, '*')].empty?
    r_path = File.join(RAILS_ROOT, 'public', type, '<%= file_name %>')
    unless File.directory?(r_path)
      FileUtils.mkdir_p(r_path)
    end
    Dir[File.join(p_path, '*')].each do |asset|
      unless File.exist?(File.join(r_path, File.basename(asset)))
        FileUtils.cp_r(asset, r_path)
      end
    end
  end
end


