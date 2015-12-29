# ai_pong

### An implementation of a neural network to play pong.  

To use: install jruby-art : https://github.com/ruby-processing/JRubyArt  
Clone this repo: `git clone https://github.com/afg419/ai_pong.git`  
Using Jruby-9.0+, run the game with: `k9 run pong_player.rb`  
  
Use the 'a' and 'd' keys to move the paddle left and right.  After some time playing (be sure not to miss!) press 't'.  This will train a neural network and data that has been collecting while you play.  It then relinquishes human control to the neural network.  The network at the time of writing plays with roughly 50% accuracy after a human playing for ~10 hits.  Some tinkering needed to improve network training results.
