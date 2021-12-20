require "./test/test_helper"
require 'minitest/autorun'
require 'minitest/spec'


class GameControllerTest < ActionDispatch::IntegrationTest
    def setup
        get "/game"
    end
    test "draw_draws_cards" do
        post "/draw"
        hand = assigns(:gameState).hand.cards.length
        assert_equal(6,hand)
    end

    #This test is shit, it tests two things and is not future-proof.
    test "play_plays_a_card" do
        card = assigns(:gameState).hand.cards[2]
        post "/play?card_id=2"     
        post "/play?column_id=0"
        field = assigns(:gameState).field
        puts field.cards[0][0]
        
        bool = card.kind_of?(MonsterCard)
        assert_equal(bool, field.contains(card))
    end

    test "moving" do 
        i=0
        while  !assigns(:gameState).player_one.hand.cards[i].kind_of?(MonsterCard) do
            i += 1
        end
        post "/play?card_id=#{i}"
        post "/play?column_id=0"
        post "/move?position=[0,0]"
        assert_response :success
        post "/move?direction=0"
        assert_response :success
    end


    test "ending turn switches turn" do
        turn_before = assigns(:gameState).turn_player
        post "/end_turn"
        turn_after = assigns(:gameState).turn_player
        assert_not_equal(turn_before, turn_after)
    end

        
end