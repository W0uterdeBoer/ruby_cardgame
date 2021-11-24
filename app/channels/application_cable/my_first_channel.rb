class MyFirstChannel < ApplicationCable::Channel
    def subscribed
        @test = false
    end

    def change
        @test = !@test
        puts @test
    end
end