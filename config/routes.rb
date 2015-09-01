Rails.application.routes.draw do

  get "login" => "sessions#new"

  post "login" => "sessions#create"
  #get "player/login", :to => "player#login", :as => :login

  #post "player/add", :to => "player#add"

  #resource :players, only: [:show, :update]
  
  get "player" => "player#show"

  post "player/update" => "player#update"

  #post "check_number" => "player#check_number"
  
  #get "player/reach", :to => "player#reach", :via =>:post

  #get "player/bingo", :to => "player#bingo", :via =>:post

  #post "player/update_deal_numbers"

  #resource :deals, only: [:index, :create, :update]
  get "deal" => "deal#index"

  post "deal/create" => "deal#create"

  post "deal/update" => "deal#update"
  
  get "qrcode" => "qrcode#index"
  #get "qrcode/index", :to => "qrcode#index", :as => :qrcode

  root "welcome#index"
end
