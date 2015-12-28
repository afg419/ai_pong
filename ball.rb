class Ball

  include Processing::Proxy

  attr_accessor :p_x, :p_y, :radius, :v_x, :v_y, :walls, :paddle, :global_width, :global_height

  def initialize(paddle, walls, global_width, global_height)
    @p_x = 500
    @p_y = 500
    @v_x = -1.5
    @v_y = 2.5
    @radius = 20
    @paddle = paddle
    @walls = walls
    @global_width = global_width
    @global_height = global_height
  end

  def collides_with_left?
    p_x - radius < walls.first.thickness
  end

  def collides_with_bottom?
    p_y + radius > global_height - walls[1].thickness
  end

  def collides_with_right?
    p_x + radius > global_width - walls.last.thickness
  end

  def collides_with_paddle?
    p_y - radius < paddle.thickness && paddle.p_x < p_x && p_x < paddle.p_x + paddle.length
  end

  def reflect
    if collides_with_left? || collides_with_right?
      self.v_x = -1 * v_x
    elsif collides_with_bottom?
      self.v_y = -1 * v_y
    elsif collides_with_paddle?
      self.v_y = rand(0.5..5.5)
    end
  end

  def sketch
    fill 255,255,255
    ellipse p_x, p_y, radius, radius
    fill 0,0,0
  end

  def update_position
    self.p_x += v_x
    self.p_y += v_y
  end


end
