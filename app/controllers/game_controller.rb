class GameController < ApplicationController
  def start
    game = Game.new()
    @gameState = game.gameState
  end
end
