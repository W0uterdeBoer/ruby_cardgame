require 'location.rb'
class Player
    attr_reader  :name ,:deck ,:hand ,:field, :number
    attr_accessor :opponent, :hp
    def initialize(*args)
      @name = args[0]
      @hand = Hand.new()
      @deck = Deck.new()     
      @number = args.size;
      @hp = 3
      case @number
        when 1
          @field = Field.new()
        when 2
          @field= args[1]
      end
    end

    def draw()
      drawnCard = @deck.cards.shift

      @hand.add(drawnCard)
      return nil
    end


end