require_relative "location.rb"
class Deck < Location
    STARTINGSIZE = 40
    attr_reader  :cards
    def initialize()
        @cards = Array.new()   
    end

    def fill(cardlist)   
        @cards=cardlist.shuffle
    end
end