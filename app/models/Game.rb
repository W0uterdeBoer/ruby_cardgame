require_relative 'location.rb'

class Game
    attr_reader :gameState
    def initialize()   
        deck = Deck.new("Wendy")
		deck.fill()
		acard = deck.cards[0]
		hand = deck.hand	
        @gameState = deck	
    end 
end