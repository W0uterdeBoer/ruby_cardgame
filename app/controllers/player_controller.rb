class PlayerController < ApplicationController
    def join()
        self.expose    
    end

    def play()
        if  session[:playing]
            column = params[:column_id]
            card = @@game.gameState.player_two_hand.cards[session[:card_id].to_i]
            card.play(column.to_i)
            session[:playing] = false
          else
            session[:card_id] = params[:card_id]
            
            session[:playing] = true     
          end    
        self.expose
        render "join"
    end

    def move()
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
        render "join"
    end

    def update
        self.expose
        render "join"
    end

    def expose
        @@game = GameController.game
        @gameState= @@game.gameState
        @a_card_is_clicked = session[:playing]
        @a_card_is_moved = session[:moving]
    end
end
