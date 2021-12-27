class PlayerController < ApplicationController
    attr_reader :this_player
    include PlayerActions

    before_action :make_player
    def make_player
        @@game = Game.new() if defined?(@@game).nil?
        @this_player = @@game.gameState.player_two unless defined?(@@game).nil?
        puts "GET FILTERED"
    end

    def join()
        session[:playing2] = false
        session[:moving2] = false
        self.expose    
    end

    def update
        self.expose
        if @@game.gameState.player_one.phase_tracker.winner != nil 
            render "game/winner"
        else
            render "join"
        end
      end

    def expose
        @@game = GameController.game
        @gameState= @@game.gameState        
        @a_card_is_clicked = session[:playing]
        @a_card_is_moved = session[:moving]
        @in_fighting_phase = session[:fighting]
        @turn_player = @@game.gameState.turn_player
    end
end
