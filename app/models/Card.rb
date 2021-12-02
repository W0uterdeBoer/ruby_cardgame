require_relative 'location.rb'
require_relative "card_decorator.rb"

class Card < Component

    attr_reader :player_name, :player 
    def initialize(player)
        @known_locations = Hash.new
        @player = player
        #@known_locations["deck"] = player.deck 
        @known_locations["hand"] = @player.hand
        @known_locations["field"] = @player.field
        @startingDeck = @player.deck
        @player_name = player.name
    end     


    def play(column) 
        if self.playCondition() 
            getPlayed(column)
        else 
            raise "playcondition was #{self.playCondition}"
        end        
    end

    def ===(card)
        puts "comparing #{self.class} and #{card.class}"
        if card.respond_to?("component")
            return self === card.component
        else
            self == card
        end
    end

private
    def playCondition()
       puts "playcondition unlocked"
       @known_locations["hand"].contains(self)
    end

    def getPlayed(column)
        puts "a card got played"
        @known_locations["hand"].remove(self)
        puts @known_locations["field"]
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

class Spell < Card
end


    