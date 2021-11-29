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
        puts "atk got called with value #{@atk}"
        @atk
    end
end

class FortifyUndead < Spell
    attr_reader :url
    def initialize(player)
      super(player)
      @url = "fortifyundead.png"
    end

    def play(card)
        if self.playCondition(card)
            puts self.playCondition(card)
            getPlayed(card)
        else
            raise "PlayCondition failed"
        end
    end

    def playCondition(card)
        super() && card.type == "undead"       
    end

    def getPlayed(card)
        puts "#{card.class} in getPlayed 1"
        card = AlterStatsDecorator.new(card,1,1)
    end
end

