require_relative '../Card.rb'

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
        binding.pry
    end 
    def no
        if self.playCondition()
            buffed_target = getPlayed(target)
            player.field.cards[i][j] = buffed_target

        else
            puts "PlayCondition failed"
            buffed_target = target
        end
        return buffed_target
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

        result = !!player_has_army_card && !!opponent_has_undead_card
        return result
    end

    def getPlayed(card)
        puts "#{card.class} in getPlayed 1"
        self.player.hand.remove(self)
        return card
    end
end
