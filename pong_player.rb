require_relative 'ball'
require_relative 'paddle'
require_relative 'wall'
require_relative '2neural_networks/lib/network_trainer'
require 'pry'

def setup
  sketch_title 'Pong!'
  background 0
  no_stroke

  @player = :human
  @training_set = [] #[{i:[s1, s2], o: o1}, ...]
  @nn = NeuralNetwork.new(2,1,5,1)
  @predicted_paddle_location = nil

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

  if @player == :human
    if key_pressed?
      if key == 'a'
        @p.p_x += -2.5
      elsif key == 'd'
        @p.p_x += 2.5
      end
    end
  end

  if @player == :computer
    if !@b.first_pass && @training_set.last[:i].length == 2
      @predicted_paddle_location ||= @nn.forward_propogate(@training_set.last[:i])[0] * width
      p @predicted_paddle_location
      if @predicted_paddle_location < @p.p_x
        @p.p_x += -2.5
      elsif @predicted_paddle_location > @p.p_x
        @p.p_x += 2.5
      end
    else
      @predicted_paddle_location = nil
    end
  end

  @b.reflect

  @walls.each do |wall|
    wall.sketch
  end

  @b.snap_shot(@training_set)

  @p.sketch
  @b.update_position
  @b.sketch
end

def key_pressed
  if key == 't'
    @nt = NetworkTrainer.new(@training_set, @nn, 0.1, 0)
    @nt.train_network(1500)
    @player = :computer
  end
end
