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

    def play()
        puts "start of play : #{session[:playing2]}"
        if  session[:playing2]
            column = params[:column_id]
            card = @@game.gameState.player_two_hand.cards[session[:card_id].to_i]    
            card.play(column.to_i)
            
            session[:playing2] = false
          else
            session[:card_id] = params[:card_id]
            
            session[:playing2] = true     
          end    
        self.expose
        render "join"
    end

    def move()
      
        if session[:moving2]
            direction = params[:direction]
            card = @@game.gameState.field.cards[session[:position][0].to_i][session[:position][1].to_i]
            
            hash = {-1 => :LF, 0 => :F, 1 => :RF}
            
            card.move(hash[direction.to_i])
            session[:moving2] = false
      
        else
            session[:position] = params[:position]
            session[:moving2] = true
            @position = session[:position]
        end
        self.expose
        render "join"
    end

    # def draw
    #     @@game.gameState.player_two.draw()
    #     self.expose
    #     render "join"
    # end

    def attack
        card = @@game.gameState.field.cards[params[:position][0].to_i][params[:position][1].to_i]
        card.move(:F)
        self.expose
        render "join"
    end

    def end_turn
        ActionCable.server.broadcast("best_room", { body: "p1_turn" })
        @@game.gameState.switch_turn
        self.update
    end

    def update
        self.expose
        render "join"
      end

    def expose
        @@game = GameController.game
        @gameState= @@game.gameState
        @a_card_is_clicked = session[:playing2]
        @a_card_is_moved = session[:moving2]
        @turn_player = @@game.gameState.turn_player
    end
end
