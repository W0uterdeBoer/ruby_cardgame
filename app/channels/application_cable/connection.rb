module ApplicationCable
  class Connection < ActionCable::Connection::Base
    #identified_by :current_user

    #def connect
    #  self.current_user = true
    #  puts "I am a Socket"
    #end
  end

end
