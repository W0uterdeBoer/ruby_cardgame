require_relative 'location.rb'

class Game
    attr_reader :gameState , :player_one
    def initialize()   
        @player_one = Player.new("Wendy")
        @player_two = Player.new("Mandy", player_one.field)
        #redcard = Redcard.new(player_one)
        #bluecard = Bluecard.new(player_one)
        cards = [MonsterCard, Bluecard]
        cardList = Array.new(40){|i| cards.sample.new(player_one)}

		player_one.deck.fill(cardList)	
        @player_two.deck.fill(cardList)       
        5.times{player_one.draw()}
        5.times{@player_two.draw()}

        @gameState = GameState.new(player_one.deck, player_one.hand, @player_two.deck, @player_two.hand, player_one.field)
    end 
end

class GameState
    attr_reader :deck , :hand , :field, :player_two_deck, :player_two_hand
    def initialize(deck, hand, player_two_deck, player_two_hand, field)
        @deck = deck
        @hand = hand
        @field = field
        @player_two_deck = player_two_deck
        @player_two_hand = player_two_hand

    end
end