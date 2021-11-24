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
    attr_reader  :cards
    def initialize()
        @cards = Array.new()   
    end

    def fill(cardlist)   
        @cards=cardlist.shuffle
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
                puts "A card got removed from the hand at position #{i}"
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

    
    def contains(card, need_position = false)
        is_in_location = false
        position = nil
        @cards.each_with_index do |row, i| 
            row.each_with_index do |card_in_location, j|
                if card == card_in_location
                    puts "Card found"
                    is_in_location = true
                    position = [i,j]
                    puts "position: #{position}"
                end
            end
        end

        if need_position && is_in_location
            return position
        else
            return is_in_location
        end
    end 


    def put(column, card)
        @cards[column][0] = card
        puts "A card got added to the field at position #{column} #{0}"
    end

    def move(position, direction)
        new_position = position.clone

        case direction
        when :F
            new_position[1] += 1
        when :LF
            new_position[0] -= 1
            new_position[1] += 1
        when :RF
            new_position[0] += 1
            new_position[1] += 1        
        else
            raise "Not a known position"            
        end  

        puts "position #{position}, new_position: #{new_position}"
        if  @cards[new_position[0]][new_position[1]] == nil
            @cards[new_position[0]][new_position[1]] = @cards[position[0]][position[1]]
            @cards[position[0]][position[1]] = @cards[new_position[0]][new_position[1]]
            puts "Card moved in field"
        end
    end
end