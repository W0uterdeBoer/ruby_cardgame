require "./test/test_helper"
require 'minitest/autorun'
require_relative '../../app/models/Card.rb'
require_relative '../../app/models/Player.rb'

class CardTest < MiniTest::Test
	DECKSIZE = 40
	def setup	
		game = Game.new()
		@player =game.player
		@field = @player.field
		@deck = @player.deck
		@acard = @deck.cards[0]
		@hand = @player.hand	
		@handSize = @hand.cards.length
	end


	def test_cards_are_instanciated	
		# skip
		assert(@acard.class.ancestors.include? Card)	
	end

	#def test_cards_in_deck_by_default
	#	assert_instance_of(Deck,  @player.deck.contain)
	#end

	def test_deck_size_is_40
		startingHand = 5
		assert_equal(@deck.cards.length, DECKSIZE-startingHand)
	end

	def test_card_in_deck_has_location_deck
		decksize = @deck.cards.length
		result = Array.new(decksize, false)

		@deck.cards.each_with_index do |card, i| 
			if	@deck.contains(card)
				result[i] = true
			end
		end
		
		assert_equal(Array.new(decksize, true), result)
	end

	def test_draw
		cardsInDeck = DECKSIZE-@handSize
		@player.draw()
		assert_equal(cardsInDeck-1, @deck.cards.length)
		assert_equal(@handSize + 1, @hand.cards.length)
	end

	def test_red_cards
		player = Player.new("Wendy")
		card = Redcard.new(player)
		assert_instance_of(Redcard, card)
	end

  def test_play_card
    playedCard=@hand.cards[0]
    playedCard.play(1)

	assert_equal(false, @hand.contains(playedCard))
    assert_equal(true, @field.contains(playedCard))
  end
end
