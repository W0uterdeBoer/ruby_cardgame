class Habitat < Location
    def initialize()
        @cards = []
    end
    
    def add(card)
        @cards << card if card.kind_of?(Structure)
    end
end