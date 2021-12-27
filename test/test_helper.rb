ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  register_spec_type(/GameTest/, Minitest::Spec)
  def play_from_void(card_type, i, player)
    card = card_type.new(player)
    player.hand.add(card)
    card.play(i)
    return card
  end
  # Run tests in parallel with specified workers
  #parallelize(workers: :number_of_processors, with: :threads)

  # Add more helper methods to be used by all tests here...
end
