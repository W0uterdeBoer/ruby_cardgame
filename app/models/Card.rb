require_relative 'location.rb'

class Card 

    def initialize(player)
        @known_locations = Hash.new
        @player = player
        #@known_locations["deck"] = player.deck
        @known_locations["hand"] = player.hand
        @known_locations["field"] = player.field
        @startingDeck = player.deck
    end     


    def play(column) 
        if self.playCondition() 
            getPlayed(column)
        end        
    end

private
    def playCondition()
       @known_locations["hand"].contains(self)
    end

    def getPlayed(column)
        puts "a card got played"
        @known_locations["hand"].remove(self)
        @known_locations["field"].put(column, self)
    end
end

class Redcard < Card
end

class Bluecard < Card
end


    