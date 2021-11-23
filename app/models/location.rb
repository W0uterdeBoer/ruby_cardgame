require_relative '../models/Card.rb'
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
    attr_reader :hand , :cards
    def initialize(hand)
        @hand = hand  
        @cards = Array.new()   
    end

    def fill(cardlist)   
        @cards=cardlist.shuffle
    end
  
    def draw()
        drawnCard = cards.shift

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
            if cardInHand === card
                removedCard = @cards.delete_at(i)
                puts "A card got removed here"
            end
            removedCard
        end
    end
end

class Field < Location
    attr_reader :cards
    def initialize()
        @cards = Array.new(3){Array.new(3)}
    end

    
    def contains(card)
        isInLocation = false
        @cards.each do |row| 
            row.each do |cardInLocation|
                if card == cardInLocation
                    isInLocation = true
                end
            end
        end
        return isInLocation
    end 

    def put(column, card)
        @cards[column][0] = card
        puts "A card got added to the field"
    end
end