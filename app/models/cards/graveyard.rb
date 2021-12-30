class Graveyard < Structure
    attr_reader :url, :player, :description
    def initialize(player)
        @player = player
        @url = "graveyard.jpg"
        @description = "graveyard"
    end 
end