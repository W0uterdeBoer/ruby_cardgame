require_relative 'location.rb'

class Card 
    attr_reader :player, :startingDeck
    def initialize(player)
        @player = player
        @startingDeck = player.deck
    end     

    def location
        cardLocation = nil
        if startingDeck.contains(self)
            cardLocation = startingDeck    
        end

        if startingDeck.hand.contains(self)
            cardLocation = startingDeck.hand
        end
        return cardLocation
    end

    def play(column) 
        if self.playCondition() 
            getPlayed(column)
        end        
    end

private
    def playCondition()
       startingDeck.hand.contains(self)
    end

    def getPlayed(column)
        puts "a card got played"
        cardLocation = self.location
        puts cardLocation
        cardLocation.remove(self)
    end
end

class Redcard < Card
end

class Bluecard < Card
end


    