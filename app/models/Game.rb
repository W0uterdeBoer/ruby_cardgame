require_relative 'location.rb'

class Game
    attr_reader :gameState
    def initialize()   
        deck = Deck.new("Wendy")
		deck.fill()
		acard = deck.cards[0]
		hand = deck.hand	
        5.times{deck.draw()}
        @gameState = GameState.new(deck,hand)
    end 
end

class GameState
    attr_reader :deck , :hand
    def initialize(deck,hand)
        @deck = deck
        @hand = hand
    end
end