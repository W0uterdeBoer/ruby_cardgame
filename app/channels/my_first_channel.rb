class MyFirstChannel < ApplicationCable::Channel
    def subscribed
        @test = false
        puts "You are subscribed tor room #{"best_#{params[:room]}"}"
        stream_from "best_#{params[:room]}"
    end

    def change
        @test = !@test
        puts @test
    end
end