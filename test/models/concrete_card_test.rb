require 'require_all'
require "./test/test_helper"
require 'minitest/autorun'
require_rel '../../app/models/concrete_cards'

class CardTest < MiniTest::Test
    def setup()
        game = Game.new()
        @player =game.player_one
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
        @skelly.play(0)
        @skelly = @fortify.play(0,0)

        assert_equal(2, @skelly.atk)
        assert_equal(2, @skelly.def)
        assert_equal(@skelly, @field.cards[0][0])
    end

    def test_fortified_skeleton_moves
        @skelly.play(0)
        @skelly = @fortify.play(0,0)
        @skelly.move("F")
        puts(@skelly.class)
        assert_equal(@skelly, @field.cards[0][1])
    end
end