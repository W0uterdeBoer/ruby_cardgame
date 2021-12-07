Rails.application.routes.draw do
  
  root "game#start"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/articles", to: "articles#index"
  get '/game', to: "game#start"
  get"/join", to: "player#join"
  post "/play", to: "game#play"
  get "/play", to: "game#update"
  post "/move", to: "game#move"
  post "/join/move", to: "player#move"
  post "/join/play", to: "player#play"
  post "/draw", to: "game#draw"
  post "/join/draw", to: "player#draw"

  post "/attack", to: "game#attack"
  post "/join/attack", to: "player#attack"

end
