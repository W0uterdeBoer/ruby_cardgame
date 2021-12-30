#require 'locations/location.rb'
class Player
    attr_reader  :name ,:deck ,:hand ,:field, :discard, :number, :phase_tracker, :hp, :habitat
    attr_accessor :opponent 
    def initialize(*args)
      @name = args[0]
      @hand = Hand.new()
      @deck = Deck.new()     
      temp_number = args.size;
      @hp = 3
      @discard = Discard.new()
      @habitat = Habitat.new()
      
      case temp_number
        when 1
          @field = Field.instance()
          @phase_tracker = PhaseTracker.instance()
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

    # start_turn should draw when automatic updating is added.
    def start_turn()
      @habitat.add(Graveyard.new(self))
    end 

    def hp=(x)
      @hp = x
      unless hp > 0 
        @phase_tracker.declare_winner(self.opponent)  
      end     
    end

    def get_closest_row
      if self.number == 1
          j = 0
      elsif self.number == 2
          j = 2
      end
      j
  end


end