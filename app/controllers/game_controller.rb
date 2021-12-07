require 'pry'
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
      puts "GAME PLAY CALLED"
      card = @@game.gameState.hand.cards[session[:card_id].to_i]
      column = params[:column_id]
      if card.class.to_s == "Skeleton"        
        card.play(column.to_i)
      elsif card.class.to_s == "FortifyUndead" 
        card.play(column.to_i, 0)
      end
      
      session[:playing] = false
    else
      session[:card_id] = params[:card_id]
      
      session[:playing] = true     
    end    
    self.update
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
  
  def draw
    @@game.gameState.player_one.draw()
    self.update
  end

  def update
    self.expose
    render "start"
  end

  def attack
    card = @@game.gameState.field.cards[params[:position][0].to_i][params[:position][1].to_i]
    card.move(:F)
    self.expose
    render "start"
  end

  private


  def expose
    @a_card_is_clicked = session[:playing]
    @a_card_is_moved = session[:moving]
    @gameState = @@game.gameState
    puts "moving after p1 #{session[:moving]}"
  end

end
