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

    def atk
        @atk
    end
end

class FortifyUndead < Spell
    attr_reader :url
    def initialize(player)
      super(player)
      @url = "fortifyundead.png"
    end

    def play(i,j)
        target = player.field.cards[i][j]
        
        if self.playCondition(target)
            buffed_target = getPlayed(target)
            player.field.cards[i][j] = buffed_target

        else
            raise "PlayCondition failed"
        end
        return buffed_target
    end

    def playCondition(card)
        super() && card.type == "undead"       
    end

    def getPlayed(card)
        puts "#{card.class} in getPlayed 1"
        card = AlterStatsDecorator.new(card,1,1)
        self.player.hand.remove(self)
        return card
    end
end

