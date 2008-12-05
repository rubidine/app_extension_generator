module <%= class_name %>Dependencies

  #
  # Pass in a block in the plugin's init.rb that calls this.
  # Whatever is in the block will be called during each rails stack setup.
  #
  def self.load &blk
    return unless blk
    ActionController::Dispatcher.to_prepare :<%= file_name %>, &blk
  end

  #
  # Pass in a block in the plugin's init.rb that calls this.
  # Whatever is in the block will be called during each rails stack teardown.
  #
  def self.unload &blk
    return unless blk
    ActionController::Dispatcher.class_eval do
      # This is what to_prepare does, but for the after_dispatch callback
      callback = ActiveSupport::Callbacks::Callback.new(
                   :after_dispatch,
                   blk,
                   :identifier => :<%= file_name %>
                 )
      @after_dispatch_callbacks | callback
    end
  end
end
