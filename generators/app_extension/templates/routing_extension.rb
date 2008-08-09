module <%= class_name %>RoutingExtension

  def draw_with_<%= file_name %>
    draw_without_<%= file_name %> do |map|
      if @<%= file_name %>_route_block
        @<%= file_name %>_route_block.call(map)
      end
      yield map
    end
  end

  def define_<%= file_name %>_routes &blk
    @<%= file_name %>_route_block = blk
  end

  public
  def self.included(base)
    base.send :alias_method_chain, :draw, :<%= file_name %>
  end

end
