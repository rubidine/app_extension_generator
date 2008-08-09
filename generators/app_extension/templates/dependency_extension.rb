module <%= class_name %>DependencyExtension

  def self.extended kls
    kls.class_eval do
      def register_<%= file_name %>_extension &blk
        if blk
          ActionController::Dispatcher.to_prepare &blk

          # ActionController::Dispatcher.new($stdout).prepare_application(true)
          # is called on reset! in script/console, but is not prepared
          # when the application is loaded for some reason, so do it manually
          blk.call if caller.last =~ /irb/
        end
      end
    end
  end

end
