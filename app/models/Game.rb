require_relative 'location.rb'

class Game
    attr_reader :gameState , :player_one
    def initialize()   
        @player_one = Player.new("Wendy")
        @player_two = Player.new("Mandy", player_one.field)
        #redcard = Redcard.new(player_one)
        #bluecard = Bluecard.new(player_one)
        cards = [MonsterCard, Bluecard]
        card_list_one = Array.new(40){|i| cards.sample.new(player_one)}
        card_list_two = Array.new(40){|i| cards.sample.new(@player_two)}

		player_one.deck.fill(card_list_one)	
        @player_two.deck.fill(card_list_two)       
        5.times{player_one.draw()}
        5.times{@player_two.draw()}

        @gameState = GameState.new(@player_one, @player_two)
    end 
end

class GameState
    attr_reader :player_one, :player_two, :deck , :hand , :field, :player_two_deck, :player_two_hand
    def initialize(player_one, player_two)
        @player_one = player_one
        @player_two = player_two
        @deck = @player_one.deck
        @hand = @player_one.hand
        @field = @player_one.field
        @player_two_deck = player_two.deck
        @player_two_hand = player_two.hand

    end
end