require_relative 'location.rb'

class Game
    attr_reader :gameState , :player
    def initialize()   
        @player= Player.new("Wendy")

        #redcard = Redcard.new(player)
        #bluecard = Bluecard.new(player)
        cards = [MonsterCard, Bluecard]
        cardList = Array.new(40){|i| cards.sample.new(player)}

		player.deck.fill(cardList)	       
        5.times{player.draw()}

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