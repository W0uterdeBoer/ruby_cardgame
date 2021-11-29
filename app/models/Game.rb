require_relative 'location.rb'

class Game
    attr_reader :gameState , :player_one
    def initialize()   
        @player_one = Player.new("Wendy")
        @player_two = Player.new("Mandy", player_one.field)

        cards = [MonsterCard, Bluecard]
        setup(@player_one, cards)
        setup(@player_two, cards)

        @gameState = GameState.new(@player_one, @player_two)
    end 
    private

    def setup(player, cards)
        deck_size = 40
        card_list = Array.new(deck_size){|i| cards.sample.new(player)}
        player.deck.fill(card_list)
        5.times{player.draw()}
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