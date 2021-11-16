require_relative '../lib/Card.rb'

class Location
    attr_reader :cards
    def contains(card)
        isInLocation = false
        cards.each do |cardInLocation| 
            if card == cardInLocation
                isInLocation = true
            end
        end
        isInLocation
    end
end

class Deck < Location
    STARTINGSIZE = 40
    attr_reader :hand
    def initialize(name)
        player = Player.new(name)
        @hand = Hand.new(player)
        cardlist=[Redcard.new(player, self), Bluecard.new(player, self)]
        @cards=Array.new(STARTINGSIZE){
            |card| card = cardlist.sample
        }
    end


    def draw()
        drawnCard = cards.shift
        puts cards.length

        hand.add(drawnCard)
        return nil
    end
end

class Hand < Location
    attr_reader :cards, :player
    
    def initialize(player)
        @cards = Array.new
    end

    def add(card)
        cards.push(card)
    end

end

class Field < Location
    attr_reader :x, :y
end