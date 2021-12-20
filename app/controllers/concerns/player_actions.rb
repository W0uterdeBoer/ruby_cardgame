require "active_support/concern"
module PlayerActions
    def self.included(base)
        p "IamRunning"
    end 

    def draw 
        puts this_player unless this_player.nil?
        #puts base.class_variable_get(:@@game)
        @this_player.draw()
        self.update
    end

    def play
        if  session[:playing]
          
          card = this_player.hand.cards[session[:card_id].to_i]
          column = params[:column_id]
          card.play(column.to_i)     
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
        card = this_player.field.cards[session[:position][0].to_i][session[:position][1].to_i]
        
        hash = {-1 => :LF, 0 => :F, 1 => :RF}
        
        card.move(hash[direction.to_i])
        session[:moving] = false
  
      else
        session[:position] = params[:position]
        session[:moving] = true
        @position = session[:position]
      end
      self.update
    end 

    def attack
      card = this_player.field.cards[params[:position][0].to_i][params[:position][1].to_i]
      card.move(:F)
      self.update
    end

    def end_turn
      if this_player == GameController.game.player_one       
        ActionCable.server.broadcast("best_room", { body: "p2_turn" })
      else 
        ActionCable.server.broadcast("best_room", { body: "p2_turn" })
      end
      GameController.game.gameState.switch_turn
      self.update
    end
end