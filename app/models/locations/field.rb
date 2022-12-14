require_relative "location.rb"
require_relative "discard.rb"
class Field < Location
    include Singleton
    attr_reader :cards
    def initialize()
        @cards = Array.new(3){Array.new(3)}
    end

    
    def contains(card, need_position = false)
        is_in_location = false
        position = nil
        @cards.each_with_index do |row, i| 
            row.each_with_index do |card_in_location, j|
                if card === card_in_location
                    is_in_location = true
                    position = [i,j]
                end
            end
        end

        if need_position && is_in_location
            return position
        else
            return is_in_location
        end
    end 


    def put(column, card)
       ended_on_field = put_on_field(column, card)
       if ended_on_field 
            cards.flatten.each do |field_card| 
                if field_card.respond_to?(:continuous_field_effect)
                    field_card.continuous_field_effect(card)  
                end
            end
       end
    end

    def move(position, direction)
        new_position = find_new_position(position, direction)
        puts "position #{position}, new_position: #{new_position}"
        if new_position[1] == -1 || new_position[1] == 3
            card = @cards[position[0]][position[1]]
            card.player.opponent.hp -= 1
            @cards[position[0]][position[1]] = nil

        elsif   @cards[new_position[0]][new_position[1]] == nil
            @cards[new_position[0]][new_position[1]] = @cards[position[0]][position[1]]
            @cards[position[0]][position[1]] = nil
            puts "Card moved in field"    
        else
            fight(position, new_position)       
        end
    end

    def fight(position, new_position)

        card =  @cards[position[0]][position[1]]
        opponent_card = @cards[new_position[0]][new_position[1]]

        if card.kind_of?(MonsterCard) && opponent_card.kind_of?(MonsterCard)
            atk_difference = card.atk - opponent_card.atk
        else
            raise "one of the fighting cards is not a monster"
        end

        if card.player.hand.check_for_battlecards()
            card.player.phase_tracker.phase = :battle
            card.player.phase_tracker.set_fighting_cards(card, opponent_card)
        elsif atk_difference > 0
            @cards[new_position[0]][new_position[1]] = card
            @cards[position[0]][position[1]] = nil
            opponent_card.player.discard.add(opponent_card)
            card.after_fight if card.respond_to?(:after_fight)

        elsif atk_difference == 0
            @cards[new_position[0]][new_position[1]] = nil
            @cards[position[0]][position[1]] = nil
            card.player.discard.add(card)
            opponent_card.player.discard.add(opponent_card)

        else 
            @cards[position[0]][position[1]] = nil
            card.player.discard.add(card)
            opponent_card.after_fight if card.respond_to?(:after_fight)
        end
    end

    def remove(card)
        binding.pry
        for i in  0..2 
            for j in 0..2 
                @cards[i][j] = nil if card == @cards[i][j]
            end
        end
    end

    private

    def find_new_position(position, direction)
        new_position = position.clone
        if @cards[position[0]][position[1]].player.number == 1
            forward_direction = 1
        else 
            forward_direction = -1 
        end

        case direction
        when :F
            new_position[1] += forward_direction
        when :LF
            new_position[0] -= 1
            new_position[1] += forward_direction
        when :RF
            new_position[0] += 1
            new_position[1] += forward_direction        
        else
            raise "Not a known position"            
        end  
        new_position
    end

    def put_on_field(column, card)
        if card.player.number == 1
            row = 0
        elsif card.player.number == 2
            row = 2
        end

        if @cards[column][row].kind_of?(MonsterCard)
            if @cards[column][row].def < card.atk
                @cards[column][row] = card
            end
        else
            @cards[column][row] = card
        end
    end 

   
end