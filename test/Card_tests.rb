 # frozen_string_literal: true
require 'minitest/autorun'
require_relative '../lib/Card.rb'
require_relative '../lib/Player.rb'

class Cardtests < MiniTest::Test
	def setup		
		@deck = Deck.new("Wendy")
		@deck.fill()
		@acard = @deck.cards[0]
		@hand = @deck.hand		
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
		card = Redcard.new(player, @deck)
		assert_instance_of(Redcard, card)
	end

end