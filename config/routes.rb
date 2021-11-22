Rails.application.routes.draw do
  
  root "game#start"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/articles", to: "articles#index"
  get '/game', to: "game#start"
  post "/play", to: "game#play"
end
