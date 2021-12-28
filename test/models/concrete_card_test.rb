require 'require_all'
require "./test/test_helper"
require 'minitest/autorun'
require_rel '../../app/models/cards'

class ConcreteCardTest < MiniTest::Test
    def setup()
        game = Game.new()
        @player = game.player_one
        @player_two = game.player_two
        @hand = @player.hand
        @field = @player.field
        @fortify = FortifyUndead.new(@player)
        @hand.add(@fortify)
        @skelly = Skeleton.new(@player)
        @hand.add(@skelly)

    end

    def test_skeleton
        
        assert_equal(1, @skelly.atk)
        assert_equal(1, @skelly.def)
    end

    def test_undead
        assert_equal("undead", @skelly.type)
    end

    def test_fortify
        "fortify-test"
        @skelly.play(0)
        @fortify.play(0)
        buffed_skelly = @field.cards[0][0]

        assert_equal(3, buffed_skelly.atk)
        assert_equal(3, buffed_skelly.def)
    end

    def test_fortified_is_on_field
        @skelly.play(0)
        @fortify.play(0)
        @skelly.move("F")
        assert_equal(false, @skelly==@field.cards[0][1])
    end

    def test_Ghoul 
        ghouly = play_from_void(Ghoul, 0, @player)
        ton = play_from_void(Skeleton, 0, @player_two)
        ton.move(:F)
        ghouly.move(:F)
        assert_equal(3, @field.cards[0][1].atk)

    end

    def test_equals_is_refexive
        @skelly.play(0)
        @fortify.play(0)
        skelly_imposter = @field.cards[0][0]

        assert_equal(true, skelly_imposter === @skelly)
        assert_equal(true, @skelly === skelly_imposter)
    end

    def test_holy_smite

        play_from_void(Skeleton, 1, @player_two)
        play_from_void(FortifyUndead, 1, @player_two)
        play_from_void(FortifyUndead, 1, @player_two)
        a_guard = play_from_void(Guard, 1, @player)

        a_guard.move(:F)
        smite = HolySmite.new(@player)
        @hand.add(smite)
        a_guard.move(:F)
        
        smite.play(420) 
        assert_equal(true, @field.cards[1][2].class == Guard)
    end

    def test_flagbearer
        p "flagtest"
        play_from_void(Guard, 0, @player)
        flagguy = play_from_void(FlagBearer, 1, @player)
        p @field.cards[0][0].class
        assert_equal(3, @field.cards[0][0].atk)
        3.times{flagguy.move(:F)}
        assert_equal(2, @field.cards[0][0].atk)
    end

    def test_shieldbearer
        card = play_from_void(ShieldBearer, 1, @player)
        card.move(:F)
        assert_equal(3, card.atk)
        card.move(:F)
        assert_equal(2, card.atk)
    end

    def test_inflict
        "testing_inflict"
        guard = play_from_void(Guard, 1, @player_two)
        guard.move(:F)
        play_from_void(Inflict_Wound, 1, @player)    
        assert_nil(@field.cards[1][1])   
    end

    def play_from_void(card_type, i, player)
        card = card_type.new(player)
        player.hand.add(card)
        card.play(i)
        return card
    end

    
end