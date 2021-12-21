class PhaseTracker
    attr_reader :fighting_cards
    attr_accessor :fighting
    def initialize()
        @fighting
    end

    def set_fighting_cards(card, opponent)
        if fighting
            @fighting_cards = [card, opponent]
        end
    end
    
end
