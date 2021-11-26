require 'location.rb'
class Player
    attr_reader  :name ,:deck ,:hand ,:field
    def initialize(*args)
      @name = args[0]
      @hand = Hand.new()
      @deck = Deck.new()     
      puts "#{args[0]} , #{args[1]}"
      case args.size
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