require_relative "../test_helper.rb"

class GameControllerTest < ActiveSupport::TestCase
  def test_play_plays_card
    game_controller=GameController.new()
    game_controller.start
    assert_equal(false,  game_controller.aCardIsClicked)
    post "/play? card_id=2"
    game_controller.play
    assert_equal(true, game_controller.aCardIsClicked)
    game_controller.play
    assert_equal(false, game_controller.aCardIsClicked)
  end
end
