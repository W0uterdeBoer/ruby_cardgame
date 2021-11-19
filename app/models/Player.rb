require 'location.rb'
class Player
    attr_reader  :name ,:deck ,:hand ,:field
    def initialize(name)
      @name = name
      @hand = Hand.new()
      @deck = Deck.new(@hand)     
      @field = Field.new()
    end

end