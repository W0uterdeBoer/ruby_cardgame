require_relative 'Card.rb'

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
        j = player.get_closest_row

        target = player.field.cards[i][j]
        
        if self.playCondition()
            buffed_target = getPlayed(target)
            player.field.cards[i][j] = buffed_target
        else
            puts "PlayCondition failed"
            buffed_target = target
        end
        return false
    end

    def playCondition()
        j = player.get_closest_row
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
        card = AlterStatsDecorator.new(card,2,2)
        self.player.hand.remove(self)
        return card
    end
end

class Ghoul < MonsterCard
    attr_reader :atk, :def, :type, :url
    def initialize(player)
        super(player)
        @atk = 2
        @def = 2
        @type = "undead"
        @url = "ghoul.jpg"
    end

    def after_fight(*args)
        card = AlterStatsDecorator.new(self, 1, 1)
        location = @known_locations["field"].contains(self, true)
        @known_locations["field"].cards[location[0]][location[1]] = card
    end 
end

class Inflict_Wound < SpellCard
    attr_reader :url
    def initialize(player)
        super(player)
        @url = "inflictwound.jpg"
    end

    def playCondition()
        exists_target = false
        
        for i in 0..(@known_locations["field"].cards.length-1)

            card = @known_locations["field"].cards[i][player.get_closest_row]
            unless card.nil? || card.player == player
                exists_target = true
            end

            card = @known_locations["field"].cards[i][1]
            unless card.nil? || card.player == player
                exists_target = true
            end
        end

        return super() && exists_target
    end 

    private

    def getPlayed(column)
        @known_locations["hand"].remove(self)
        j = player.get_closest_row

        card = @known_locations["field"].cards[column][j]
        if  card != nil
            if card.def < 4
                card.destroy()
            end
        end

        card = @known_locations["field"].cards[column][1]
        if  card != nil
            if card.def < 3
                card.destroy()
            end
        end
    end

end