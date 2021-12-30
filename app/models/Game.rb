require 'require_all'
require_relative 'locations/deck.rb'
#require_rel 'locations/*.rb'
require_rel 'cards'
class Game
    attr_reader :gameState , :player_one, :player_two
    def initialize()   
        @player_one = Player.new("Wendy")
        @player_two = Player.new("Mandy", player_one.field, player_one.phase_tracker)

        @player_one.opponent = @player_two
        @player_two.opponent = @player_one
        cards = [MonsterCard, SpellCard]
        first_deck = [Skeleton, FortifyUndead, Ghoul, InflictWound]
        second_deck = [Guard, HolySmite, FlagBearer, ShieldBearer]
        setup(@player_one, first_deck)
        setup(@player_two, second_deck)

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
    attr_reader :player_one, :player_two, :deck , :hand , :field, :player_two_deck, :player_two_hand, :turn_player
    attr_accessor
    def initialize(player_one, player_two)
        @player_one = player_one
        @player_two = player_two
        @deck = @player_one.deck
        @hand = @player_one.hand
        @field = @player_one.field
        @player_two_deck = player_two.deck
        @player_two_hand = player_two.hand
        @turn_player = player_one
    end



    def switch_turn
        if @turn_player == player_one
            @turn_player = player_two
        elsif @turn_player == player_two
            @turn_player = player_one
        end
        @turn_player.start_turn()
    end
    
end