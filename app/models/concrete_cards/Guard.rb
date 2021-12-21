require_relative '../Card.rb'
require_relative '../location.rb'
class Guard < MonsterCard
    attr_reader :atk, :def, :url, :type
    def initialize(player)
        super(player)
        @atk = 2
        @def = 2
        @url = "guard.jpg"
        @type = "army"
    end
end

class HolySmite < SpellCard
    attr_reader :url, :battlecard
    def initialize(player)
      super(player)
      @url = "holysmite.jpg"
    end

    def play(i)
       
        if self.playCondition()
            getPlayed()
            return true
        else
            puts "PlayCondition failed"
        end
        return false
    end

    def playCondition()
        for card in self.player.field.cards.flatten.compact
            if card.kind_of?(MonsterCard)
                target_correct = (card.type == "army" && card.player == self.player)               
                player_has_army_card = true if !!target_correct

                possible_atk_target = (card.type == "undead" && card.player == self.player.opponent)
                opponent_has_undead_card = true if possible_atk_target  
            end        
        end
        fighting_phase = player.phase_tracker.fighting
        p [!!player_has_army_card ,!!opponent_has_undead_card, fighting_phase]
        result = !!player_has_army_card && !!opponent_has_undead_card && fighting_phase
        return result
    end

    def getPlayed()
        self.player.hand.remove(self)
        cards = player.phase_tracker.fighting_cards
        player.phase_tracker.fighting = false

        position_1 = player.field.contains(cards[0], true)
        position_2 = player.field.contains(cards[1], true)
        self.player.field.fight(position_1, position_2)

        puts "#{self.class} in getPlayed 1"       
    end
end
