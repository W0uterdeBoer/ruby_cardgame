require_relative 'Card.rb'
require_relative 'Player.rb'

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

    def remove(card)
        raise "remove not implemented."
    end
end

class Deck < Location
    STARTINGSIZE = 40
    attr_reader :hand 
    def initialize(hand)
        @hand = hand     
    end

    def fill(cardlist)   
        @cards=Array.new(STARTINGSIZE){
            |card| card = cardlist.sample
        }
    end

    def draw()
        drawnCard = cards.shift
        puts cards.length

        @hand.add(drawnCard)
        return nil
    end
end

class Hand < Location
    
    def initialize()
        @cards = Array.new()
    end

    def add(card)
        @cards.push(card)
    end

    def remove(card)
        cards.each_with_index do |cardInHand, i| 
            if cardInHand == card
                removedCard = @cards.delete_at(i)
            end
            removedCard
        end
    end
end

class Field < Location
    attr_reader :x, :y
end