require 'location.rb'
class Player
    attr_reader  :name ,:deck ,:hand ,:field
    def initialize(name)
      @name = name
      @hand = Hand.new()
      @deck = Deck.new()     
      @field = Field.new()
    end

    def draw()
      drawnCard = @deck.cards.shift

      @hand.add(drawnCard)
      return nil
  end

end