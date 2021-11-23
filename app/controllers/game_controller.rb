class GameController < ApplicationController
  def start
    @@game = Game.new()
    @gameState = @@game.gameState
    @@aCardIsClicked = false
    @aCardIsClicked = @@aCardIsClicked
  end
  
  def play
    if @@aCardIsClicked
      column = params[:column_id]
      @@card.play(column.to_i)
      @@aCardIsClicked = false
      @aCardIsClicked = @@aCardIsClicked
      puts @aCardIsClicked
    else
      i = params[:card_id]
      @@card = @@game.gameState.hand.cards[i.to_i]
      @@aCardIsClicked = true
      @aCardIsClicked = @@aCardIsClicked
      puts @aCardIsClicked
    end
    @gameState = @@game.gameState
    render "start"
  end

end
