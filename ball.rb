class Ball

  include Processing::Proxy

  attr_accessor :p_x, :p_y, :radius, :v_x, :v_y, :walls, :paddle, :global_width, :global_height, :first_pass

  def initialize(paddle, walls)
    @p_x = 500
    @p_y = 100
    @v_x = rand(-0.5..0.5)
    @v_y = 3.5
    @radius = 20
    @paddle = paddle
    @walls = walls
    @global_width = $app.width
    @global_height = $app.height
    @first_pass = true
    @second_pass = true
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

  def off_screen?
    p_y < 0
  end

  def reflect
    if collides_with_left? || collides_with_right?
      self.v_x = -1 * v_x
    elsif collides_with_bottom?
      self.v_y = -1 * v_y
    elsif collides_with_paddle?
      self.v_y = rand(3.0..4.0)
      self.v_x *= rand(0.5..2.5)
    elsif off_screen?
      reset_ball
    end
  end

  def reset_ball
    self.p_x = rand(global_width/10.0..9/10.0*global_width)
    self.p_y = 50
    self.v_x = rand(-1.0..1.0)
    self.v_y = rand(2.0..4.0)
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

  def snap_shot(training_set)
    if p_y > global_height/2.0 && @first_pass
      @first_pass = false
      training_set << {i:[]}
      training_set.last[:i] << (p_x.to_f)/(global_width.to_f)
    elsif p_y > 3*global_height/4.0 && @second_pass
      @second_pass = false
      training_set.last[:i] << (p_x.to_f)/(global_width.to_f)
    elsif collides_with_bottom?
      training_set.last[:i] << (p_x.to_f)/(global_width.to_f)
    elsif collides_with_paddle?
      @first_pass = true
      @second_pass = true
      training_set.last[:o] = [(paddle.p_x.to_f)/(global_width)]
    elsif off_screen?
      @second_pass = true
      @first_pass = true
      training_set.last[:o] = [(p_x.to_f - paddle.length/2.0)/global_width]
    end
  end
end
