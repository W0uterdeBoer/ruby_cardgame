require_relative '../lib/location.rb'

class Card 
    attr_reader :player, :startingDeck
    def initialize(player, deck)
        @player = player
        @startingDeck = deck
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
end

class Redcard < Card
end

class Bluecard < Card
end

    