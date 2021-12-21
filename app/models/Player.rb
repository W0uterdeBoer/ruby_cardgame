require 'location.rb'
class Player
    attr_reader  :name ,:deck ,:hand ,:field, :number, :phase_tracker
    attr_accessor :opponent, :hp
    def initialize(*args)
      @name = args[0]
      @hand = Hand.new()
      @deck = Deck.new()     
      temp_number = args.size;
      @hp = 3
      case temp_number
        when 1
          @field = Field.new()
          @phase_tracker = PhaseTracker.new()
          @number = 1
        when 3
          @field= args[1]
          @phase_tracker = args[2]
          @number = 2
      end
    end

    def draw()
      drawnCard = @deck.cards.shift

      @hand.add(drawnCard)
      return nil
    end


end