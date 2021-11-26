require_relative 'location.rb'

class Card 

    def initialize(player)
        @known_locations = Hash.new
        @player = player
        #@known_locations["deck"] = player.deck
        @known_locations["hand"] = @player.hand
        @known_locations["field"] = @player.field
        @startingDeck = @player.deck
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

        position = @known_locations["field"].contains(self, true)
        puts position
        if position
            puts "position exists"
            @known_locations["field"].move(position, direction)
        end
    end 
end

class Bluecard < Card
end


    