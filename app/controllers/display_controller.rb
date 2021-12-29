class DisplayController < ApplicationController

    def description
        name = params[:name]
        p name
        p name.constantize
        @text = name.constantize.new(Player.new("MockPlayer")).description
        render plain: @text
    end
end