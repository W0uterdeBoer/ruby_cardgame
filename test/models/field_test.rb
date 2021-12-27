require 'require_all'
require_relative "../test_helper.rb"
require 'minitest/autorun'
require_relative '../../app/models/Card.rb'
require_relative '../../app/models/Player.rb'
require_rel '../../app/models/concrete_cards'
class FieldTest < ActiveSupport::TestCase
	DECKSIZE = 40

  def setup()
    @player_one = Player.new("Wendy")
    @field = @player_one.field
    @phase_tracker = @player_one.phase_tracker
    @player_two = Player.new("Mandy", @field, @phase_tracker)
    @hand = @player_one.hand
    @deck = @player_one.deck
  end

  def test_move
    played_card = play_from_void(MonsterCard, 0, @player_one)

	  @field.cards[0][0].move("RF")

	  assert_equal(played_card, @field.cards[1][1])
	  assert_nil(@field.cards[0][0])
  end

  def test_fight
    played_card = play_from_void(Skeleton, 0, @player_one)  
    @field.cards[0][0].move("RF")

    played_card = play_from_void(Skeleton, 2, @player_two)  
    @field.cards[2][2].move("LF")

    assert_nil(@field.cards[1][1])
  end

end