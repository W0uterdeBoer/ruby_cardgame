class GameController < ApplicationController
  attr_reader :aCardIsClicked
  attr_reader :game

  def start
    @@game = Game.new()
    session[:playing] = false
    session[:moving] = false
    self.expose
  end
  
  def play
    if  session[:playing]
      
      card = @@game.gameState.hand.cards[session[:card_id].to_i]
      column = params[:column_id]
      if card.class.to_s == "Skeleton"        
        card.play(column.to_i)
      elsif card.class.to_s == "FortifyUndead" 
        card.play(0,column.to_i)
      end
      
      session[:playing] = false
    else
      session[:card_id] = params[:card_id]
      
      session[:playing] = true     
    end    
    self.expose  
    render "start" 
  end

  def move
    if session[:moving]
      direction = params[:direction]
      card = @@game.gameState.field.cards[session[:position][0].to_i][session[:position][1].to_i]
      
      hash = {-1 => :LF, 0 => :F, 1 => :RF}
      
      card.move(hash[direction.to_i])
      session[:moving] = false

    else
      session[:position] = params[:position]
      session[:moving] = true
      @position = session[:position]
    end
    self.expose
    render "start"
  end 

  def self.game
    puts "Join asks the gamestate"
    @@game 
  end
  private

  def expose
    @a_card_is_clicked = session[:playing]
    @a_card_is_moved = session[:moving]
    @gameState = @@game.gameState
  end

end
