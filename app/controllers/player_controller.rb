class PlayerController < ApplicationController
    def join()
        self.expose    
    end

    def play()
        puts "start of play : #{session[:playing2]}"
        if  session[:playing2]
            column = params[:column_id]
            card = @@game.gameState.player_two_hand.cards[session[:card_id].to_i]
            if card.class.to_s == "Skeleton"        
                card.play(column.to_i)
            elsif card.class.to_s == "FortifyUndead" 
              card.play(column.to_i, 2)
            end
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

    def draw
        @@game.gameState.player_two.draw()
        self.expose
        render "join"
    end

    def attack
        card = @@game.gameState.field.cards[params[:position][0].to_i][params[:position][1].to_i]
        card.move(:F)
        self.expose
        render "join"
    end

    def expose
        @@game = GameController.game
        @gameState= @@game.gameState
        @a_card_is_clicked = session[:playing2]
        @a_card_is_moved = session[:moving2]
        puts "playing2 after p2 before #{session[:playing2]}"
        #ActionCable.server.broadcast("best_room", { body: "This Room is Best Room." })
        puts "playing2 after p2 and broadcast #{session[:playing2]}"
    end
end
