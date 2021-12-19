require "active_support/concern"
module PlayerActions
    def self.included(base)
        p "IamRunning"
    end 

    def draw 
        puts @this_player unless @this_player.nil?
        puts this_player unless this_player.nil?
        #puts base.class_variable_get(:@@game)
        @this_player.draw()
        self.update
    end
end