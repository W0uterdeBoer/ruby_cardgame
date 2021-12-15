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