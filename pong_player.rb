require_relative 'ball'
require_relative 'paddle'
require_relative 'wall'

def setup
  sketch_title 'Pong!'
  background 0
  no_stroke

  @p = Paddle.new
  @walls = [Wall.new(:left, 20, width, height),
    Wall.new(:right, 20, width, height),
    Wall.new(:bottom, 20, width, height)]
  @b = Ball.new(@p,@walls, width, height)
end

def settings
  size 800, 800, P2D
  smooth
end

def draw
  fill 0, 20
  rect 0, 0, width, height

  if key_pressed?
    if key == 'a'
      @p.p_x += -2.5
    elsif key == 'd'
      @p.p_x += 2.5
    end
  end

  @b.reflect

  @walls.each do |wall|
    wall.sketch
  end
  @p.sketch
  @b.update_position
  @b.sketch
end
