require "require_all"
require_relative '../Card.rb'
require_rel '../locations'
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

        fighting_phase = (player.phase_tracker.phase == :battle)
        result = !!player_has_army_card && !!opponent_has_undead_card && fighting_phase
        return result
    end

    def getPlayed()
        self.player.hand.remove(self)
        cards = player.phase_tracker.fighting_cards
        player.phase_tracker.phase = :main

        position_1 = player.field.contains(cards[0], true)
        position_2 = player.field.contains(cards[1], true)
        if cards[1].def < 6
            @known_locations["field"].cards[position_2[0]][position_2[1]] = cards[0]
            @known_locations["field"].cards[position_1[0]][position_1[1]] = nil
        end


        puts "#{self.class} in getPlayed 1"       
    end
end

class FlagBearer < MonsterCard
    attr_reader :type, :url, :atk, :def
    def initialize(player)
        super(player)
        @url = "flagbearer.jpg"
        @type = "army"
        @atk = 0
        @def = 1
    end

    def getPlayed(column)    
        super(column)
        on_field_cards = @known_locations["field"].cards.flatten.compact

        on_field_cards.each  do |card|    
            continuous_field_effect(card)           
        end   
    end

    def continuous_field_effect(card)
        if  card.type == "army" && card.class != FlagBearer
            new_card = AlterStatsDecorator.new(card, 1, 0)
            position = @known_locations["field"].contains(card, true)
            @known_locations["field"].cards[position[0]][ position[1]] = new_card
        end
    end
end

