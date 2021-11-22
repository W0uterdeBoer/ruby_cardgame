class GameController < ApplicationController
  def start
    game = Game.new()
    @gameState = game.gameState
  end
  
  def play
    puts "I am in GameController"
  end 
end
