class Wall

  attr_reader :side, :thickness, :global_height, :global_width

  include Processing::Proxy

  def initialize(side, thickness)
    @side = side
    @thickness = thickness
    @global_width = $app.width
    @global_height = $app.height
  end

  def left_sketch
    fill 255,255,255
    rect 0,0,thickness, global_height
    fill 0,0,0
  end

  def bottom_sketch
    fill 255,255,255
    rect 0, global_height-thickness , global_width, thickness
    fill 0,0,0
  end

  def right_sketch
    fill 255,255,255
    rect global_width - thickness,0 , thickness, global_height
    fill 0,0,0
  end

  def sketch
    case side
    when :left then left_sketch
    when :right then right_sketch
    when :bottom then bottom_sketch
    end
  end

end
