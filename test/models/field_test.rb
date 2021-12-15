require 'require_all'
require_relative "../test_helper.rb"
require 'minitest/autorun'
require_relative '../../app/models/Card.rb'
require_relative '../../app/models/Player.rb'
require_rel '../../app/models/concrete_cards'
class FieldTest < MiniTest::Test
	DECKSIZE = 40

  def setup()
    @player_one = Player.new("Wendy")
    @field = @player_one.field
    @player_two = Player.new("Mandy", @field)
    @hand = @player_one.hand
    @deck = @player_one.deck
  end

  def test_move
  	played_card = MonsterCard.new(@player_one)
	  @hand.add(played_card)
	  @hand.cards[-1].play(0)

	  @field.cards[0][0].move("RF")

	  assert_equal(played_card, @field.cards[1][1])
	  assert_nil(@field.cards[0][0])
  end

  def test_fight
    played_card = Skeleton.new(@player_one)
	  @hand.add(played_card)
	  @hand.cards[-1].play(0)   
    @field.cards[0][0].move("RF")

    played_card = Skeleton.new(@player_two)
    
	@player_two.hand.add(played_card)
	@player_two.hand.cards[-1].play(2)   
    @field.cards[2][2].move("LF")

    assert_nil(@field.cards[1][1])
  end

end