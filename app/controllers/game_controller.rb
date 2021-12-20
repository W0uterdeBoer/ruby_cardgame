require 'pry'
class GameController < ApplicationController
  attr_reader :game
  attr_reader :this_player

  include PlayerActions
  

  before_action :make_player
  def make_player
    @@game = Game.new() if defined?(@@game).nil?
    @this_player = @@game.gameState.player_one unless defined?(@@game).nil?
    puts "GET FILTERED"
  end

  def start
    @@game = Game.new()
    session[:playing] = false
    session[:moving] = false
    self.expose
  end

  def self.game
    puts "Someone asks the gamestate"
    @@game 
  end
  
  def update
    self.expose
    render "start"
  end

 

  

  private


  def expose
    @a_card_is_clicked = session[:playing]
    @a_card_is_moved = session[:moving]
    @gameState = @@game.gameState
    @turn_player = @@game.gameState.turn_player
    puts "moving after p1 #{session[:moving]}"
  end

end
