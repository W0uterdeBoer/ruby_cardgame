require_relative "../card_decorator.rb"
require "pry"
class Card < Component

    attr_reader :player
    def initialize(player)
        @known_locations = Hash.new
        @player = player
        #@known_locations["deck"] = player.deck 
        @known_locations["hand"] = @player.hand
        @known_locations["field"] = @player.field
        @startingDeck = @player.deck
    end     


    def play(column) 
        if self.playCondition
            getPlayed(column)
        else 
            raise "playcondition was #{self.playCondition}"
        end    
        false    
    end

    def ===(card)
        if card.respond_to?("component")
            return self === card.component
        else
            self == card
        end
    end

    def playCondition()
        puts "playcondition unlocked"
        correct_phase = (player.phase_tracker.phase == :main)
        correct_location = @known_locations["hand"].contains(self)   
        #pry-byebug
        #binding.pry
        correct_phase && correct_location
    end
    
    def destroy()
        @known_locations.each_value do |location|
            card_position = location.contains(self)
            target = card_position unless card_position.nil?
            location.remove(self)
            player.discard.cards.push(self)
        end
    end

private
    

    def getPlayed(column)
        puts "a card got played"
        @known_locations["hand"].remove(self)
        @known_locations["field"].put(column, self)
    end
   
end

class MonsterCard < Card
    DIRECTIONS = [:LF, :F, :RF].freeze

    def move(direction)

        unless DIRECTIONS.include?(direction.to_sym)   
            raise "Invalid move input"  
        else
            direction = direction.to_sym 
        end 
        
        #found the issue, self refers to monstercard, not to decorator
        position = @known_locations["field"].contains(self, true)
        puts "position: #{position}" 
        if position
            puts "position exists"
            @known_locations["field"].move(position, direction)
        end
    end 

    def type
        raise "type not implemented"
    end 
end

class SpellCard < Card
end


    