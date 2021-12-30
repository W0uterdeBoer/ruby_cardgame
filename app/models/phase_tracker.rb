class PhaseTracker
    attr_reader :fighting_cards, :winner
    attr_accessor :phase 
    include Singleton
    def initialize()
        @phase = :main
    end

    def set_fighting_cards(card, opponent)
        if phase == :battle
            @fighting_cards = [card, opponent]
        end
    end

    def declare_winner(player)
        @winner = player
    end
    
end


    
