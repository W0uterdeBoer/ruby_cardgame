class PlayerController < ApplicationController
    def join()
        self.expose    
    end

    def play()
        self.expose
        render "join"
    end

    def move()
        self.expose
        render "join"
    end

    def update
        self.expose
        render "join"
    end

    def expose
        game = GameController.game
        @gameState= game.gameState
    end
end
