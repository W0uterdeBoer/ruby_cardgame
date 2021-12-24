class PhaseTracker
    attr_reader :fighting_cards
    attr_accessor :phase
    def initialize()
        @phase = :main
    end

    def set_fighting_cards(card, opponent)
        if phase == :battle
            @fighting_cards = [card, opponent]
        end
    end
    
end


    
