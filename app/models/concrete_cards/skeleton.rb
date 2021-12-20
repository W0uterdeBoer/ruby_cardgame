require_relative '../Card.rb'

class Skeleton < MonsterCard
    attr_reader :atk, :def, :type, :url
    def initialize(player)
        super(player)
        @atk = 1
        @def = 1
        @type = "undead"
        @url = "skeleton.jpg"
    end
end

class FortifyUndead < SpellCard
    attr_reader :url
    def initialize(player)
      super(player)
      @url = "fortifyundead.png"
    end

    def play(i)
        if player.number == 1
            j = 0
        elsif player.number == 2
            j = 2
        end

        target = player.field.cards[i][j]
        
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
        if player.number == 1
            j = 0
        elsif player.number == 2
            j = 2
        end
        viable_target = false
        for card in self.player.field.cards.transpose[j].compact
            if card.type == "undead"
                viable_target = true
            end
        end
        return super() && viable_target
      
    end

    def getPlayed(card)
        puts "#{card.class} in getPlayed 1"
        card = AlterStatsDecorator.new(card,1,1)
        self.player.hand.remove(self)
        return card
    end
end

