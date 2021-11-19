require_relative 'location.rb'

class Game
    attr_reader :gameState
    def initialize()   
        player= Player.new("Wendy")

        redcard = Redcard.new(player)
        bluecard = Bluecard.new(player)
        cardlist=[redcard, bluecard]
        
		player.deck.fill(cardlist)	       
        5.times{player.deck.draw()}

        @gameState = GameState.new(player.deck, player.hand, player.field)
    end 
end

class GameState
    attr_reader :deck , :hand , :field
    def initialize(deck, hand, field)
        @deck = deck
        @hand = hand
        @field = field
    end
end