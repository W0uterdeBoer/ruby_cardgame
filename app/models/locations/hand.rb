require_relative "location.rb"
class Hand < Location
    
    def initialize()
        @cards = Array.new()
    end

    def add(card)
        @cards.push(card)
    end

    def remove(card)
        cards.each_with_index do |cardInHand, i| 
            if cardInHand === card
                removedCard = @cards.delete_at(i)
            end
            removedCard
        end
    end

    def check_for_battlecards()
        
        battle_cards_exist = false
        for card in cards
            battle_cards_exist = true if card.respond_to?(:battlecard)
        end
        p "BATTLECARDSDETECTED" if battle_cards_exist
        return battle_cards_exist
    end
end