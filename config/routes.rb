Rails.application.routes.draw do

  get "login" => "sessions#new"

  post "login" => "sessions#create"
  
  get "player" => "player#show"

  post "player/update" => "player#update"

  get "deal" => "deal#index"

  post "deal/create" => "deal#create"

  post "deal/update" => "deal#update"
  
  get "qrcode" => "qrcode#index"

  post "qrcode/update" => "qrcode#update"
  
  root "welcome#index"
end
