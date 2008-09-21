module <%= class_name %>DependencyExtension

  def self.extended kls
    kls.class_eval do
      def register_<%= file_name %>_extension &blk
        if blk
          ActionController::Dispatcher.to_prepare :<%= file_name %>, &blk
        end
      end
    end
  end

end
