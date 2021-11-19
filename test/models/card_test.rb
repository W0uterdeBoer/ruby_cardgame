require "./test/test_helper"
require 'minitest/autorun'
require_relative '../../app/models/Card.rb'
require_relative '../../app/models/Player.rb'

class CardTest < MiniTest::Test
	def setup	
		player =Player.new("Wendy")
		@deck = player.deck

		redcard = Redcard.new(player)
        bluecard = Bluecard.new(player)
        cardlist=[redcard, bluecard]

		@deck.fill(cardlist)
		@acard = @deck.cards[0]
		@hand = player.hand	
	end


	def test_cards_are_instanciated	
		# skip
		assert_equal(@acard.player.name , 'Wendy')	
	end

	def test_cards_in_deck_by_default
		assert_instance_of(Deck,  @acard.location)
	end

	def test_deck_size_is_40
		assert_equal(@deck.cards.length, 40)
	end

	def test_card_in_deck_has_location_deck
		decksize = @deck.cards.length
		result = Array.new(decksize, false)

		@deck.cards.each_with_index do |card, i| 
			if	card.location == @deck
				result[i] = true
			end
		end
		
		assert_equal(Array.new(decksize, true), result)
	end

	def test_draw
		@deck.draw()

		assert_equal(39, @deck.cards.length)
		assert_equal(1, @hand.cards.length)
	end

	def test_red_cards
		player = Player.new("Wendy")
		card = Redcard.new(player)
		assert_instance_of(Redcard, card)
	end

  def test_play_card
    @field = Field.new()
    5.times{@deck.draw()}
    playedCard=@hand.cards[0]
    playedCard.play(1)

	assert_equal(false, @hand.contains(playedCard))
    #assert_equal(true, @field.contains(playedCard))
  end
end
