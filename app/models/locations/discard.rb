require_relative "location.rb"
class Discard < Location
    attr_reader :cards
    def initialize()
        @cards = []
    end 

    def add(card)
        @cards.push(card)
    end
end