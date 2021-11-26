require 'location.rb'
class Player
    attr_reader  :name ,:deck ,:hand ,:field, :number
    def initialize(*args)
      @name = args[0]
      @hand = Hand.new()
      @deck = Deck.new()     
      puts "#{args[0]} , #{args[1]}"
      @number = args.size;
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