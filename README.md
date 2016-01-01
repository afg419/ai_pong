# ai_pong

### An implementation of a neural network to play pong.  

To use: install jruby-art : https://github.com/ruby-processing/JRubyArt  
Clone this repo: `git clone https://github.com/afg419/ai_pong.git`  
Using Jruby-9.0+, run the game with: `k9 run pong_player.rb`  
  
Use the 'a' and 'd' keys to move the paddle left and right.  After some time playing press 't'.  This will train a neural network using data that has been collecting while you play (and some collected previously).  It then relinquishes human control to the neural network.  The network at the time of writing plays with roughly 75% accuracy on 'soft' trajectory shots if trained immediately, and will improve if trained again with 't' as play continues.  At any time you can press 'g' to store all data collected from play thus far, so that future runs of the game will begin with stronger training set.
