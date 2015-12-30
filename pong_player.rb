require_relative 'ball'
require_relative 'paddle'
require_relative 'wall'
require_relative '2neural_networks/lib/network_trainer'
require_relative 'trainer'
require 'pry'
require 'csv'

def setup
  sketch_title 'Pong!'
  background 0
  no_stroke

  @player = :human
  @training_set = TrainingData.new.data
  @nn = NeuralNetwork.new(3,1,5,1)
  @predicted_paddle_location = nil

  @counter = 0

  @p = Paddle.new
  @walls = [Wall.new(:left, 20),
    Wall.new(:right, 20),
    Wall.new(:bottom, 20)]
  @b = Ball.new(@p,@walls)
end

def settings
  size 800, 800, P2D
  smooth
end

def save_training_data_to_file(trainer)
  `rm -rf trainer.rb`
  `echo "class TrainingData" >> trainer.rb`
  `echo "\tdef data" >> trainer.rb`
  `echo "\t\t#{trainer}" >> trainer.rb`
  `echo "\tend" >> trainer.rb`
  `echo "end" >> trainer.rb`
end

def draw
  fill 0, 20
  rect 0, 0, width, height

  @walls.each do |wall|
    wall.sketch
  end

  if @player == :human
    human_controls
  end

  if @player == :computer
    network_controls
  end
  # @b.snap_shot_timer(@training_set,@time)
  @b.snap_shot(@training_set)
  @b.reflect
  @b.update_position
  @p.sketch
  @b.sketch
end

def key_pressed
  if key == 't'
    usable_training_set = @training_set.reject{|i_o| i_o[:o].nil?}
    @nt = NetworkTrainer.new(usable_training_set, @nn, 0.1, 2)
    @nt.train_network(1500)
    @player = :computer
  end
end

def human_controls
  if key_pressed?
    if key == 'a'
      @p.p_x += -2.5
    elsif key == 'd'
      @p.p_x += 2.5
    end
  end
end

def network_controls
  if !@b.first_pass && @training_set.last[:i].length == 3
    @predicted_paddle_location ||= @nn.forward_propogate(@training_set.last[:i])[0] * width
    if @predicted_paddle_location < @p.p_x
      @p.p_x += -2.5
    elsif @predicted_paddle_location > @p.p_x
      @p.p_x += 2.5
    end
  else
    @predicted_paddle_location = nil
  end

  if @counter == 5
    usable_training_set = @training_set.reject{|i_o| i_o[:o].nil?}
    @nt = NetworkTrainer.new(usable_training_set[-5..-1], @nn, 0.1, 2)
    @nt.train_network(500)
    @counter = 0
  end
end
# def network_controls_from_time_train
#   if @time > 256
#     @predicted_paddle_location ||= @nn.forward_propogate(@training_set.last[:i])[0] * width
#     if @predicted_paddle_location < @p.p_x
#       @p.p_x += -4.5
#     elsif @predicted_paddle_location > @p.p_x
#       @p.p_x += 4.5
#     end
#   else
#     @predicted_paddle_location = nil
#   end
# end
