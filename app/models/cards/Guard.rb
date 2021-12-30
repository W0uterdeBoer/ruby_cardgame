require "require_all"
require_relative 'Card.rb'
require_rel '../locations'
class Guard < MonsterCard
    attr_reader :atk, :def, :url, :type, :description
    def initialize(player)
        super(player)
        @atk = 2
        @def = 2
        @url = "guard.jpg"
        @type = "army"

        @description = "type: #{@type} I am a guard "
    end
end

class HolySmite < SpellCard
    attr_reader :url, :battlecard, :description
    def initialize(player)
      super(player)
      @url = "holysmite.jpg"
      @description = "An army creature automatically defeats an undead creature, not optional"
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
        self.player.discard.add(self)
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
    attr_reader :type, :url, :atk, :def, :description
    def initialize(player)
        super(player)
        @url = "flagbearer.jpg"
        @type = "army"
        @atk = 0
        @def = 1
        @description =  "All #{@type} monsters on the field except FlagBearer gain 1 atk"
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
            new_card = AlterStatsDecorator.new(card, 1, 0, self)
            position = @known_locations["field"].contains(card, true)
            @known_locations["field"].cards[position[0]][ position[1]] = new_card
        end
    end

    def alterStatsCondition()
        @known_locations["field"].contains(self)
    end

end

class ShieldBearer < MonsterCard
    attr_reader  :def, :type, :url, :description
    def initialize(player)
        super(player)
        @atk = 4
        @def = 3
        @type = "army"
        @url = "shieldbearer.jpg"
        @description = "type : #{@type} ShieldBearer loses 1 atk for each line it is away from first line"
    end

    def atk
        location = @known_locations["field"].contains(self,true)
        if location != false
            if player.number == 2
                distance_to_base = 2-location[1]
            else 
                distance_to_base = location[1]
            end
            reduction = distance_to_base + 1
            @atk - reduction
        else
            @atk           
        end
    end

end

