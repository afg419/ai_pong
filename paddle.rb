class Paddle

  include Processing::Proxy

  attr_accessor :p_x, :length, :v_x, :thickness

  def initialize(thickness = 20)
    @p_x = 450
    @length = 100
    @v_x = 0
    @thickness = thickness
  end

  def sketch
    fill 255,255,255
    rect p_x, 0, length, thickness
    fill 0,0,0
  end

end
