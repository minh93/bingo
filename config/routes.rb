Rails.application.routes.draw do  
  get 'player/index', :to => 'player#index', :as => :player

  get 'game/index', :to => 'game#index', :as => :game

  get 'qrcode/index', :to => 'qrcode#index', :as => :qrcode

  get 'welcome/index'

  get 'player/checkNumber', :to => 'player#checkNumber', :as=> 'checkNumber', :via => :post 

  get 'player/reach', :to => 'player#reach', :via =>:post

  get 'player/bingo', :to => 'player#bingo', :via =>:post

  get 'player/new', :to => 'player#new', :as => :new

  post 'player/create', :to => 'player#create'

  get 'player/show', :to => 'player#show'

  root 'welcome#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
     resources :players

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
