Rails.application.routes.draw do

  get 'help' => 'users#help'
  get 'about' => 'users#about'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get 'admin' => 'users#admin'
  get 'playerIndex' => 'game_lobbies#playerIndex'
  
  
  get 'lobbies' => 'game_lobbies#GameLobby'
  get 'lobbies/GameOne' => 'game_lobbies#GameOne'
  get 'lobbies/GameTwo' => 'game_lobbies#GameTwo'
  get 'lobbies/GameThree' => 'game_lobbies#GameThree'
  get 'lobbies/GameFour' => 'game_lobbies#GameFour'
  get 'lobbies/GameLobby' => 'game_lobbies#GameLobby'
  root 'users#home'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  resources :users do
    # put 'promote'
    # put 'commend
    collection do
      get 'destroy_old_guests'
      # put "promote"
      # put "report"
      # put "commend"
    end
  end
  get "users/:id/commend" => "users#commend", :as => "commend"
  get "users/:id/report" => "users#report", :as => "report"
  get "users/:id/promote" => "users#promote", :as => "promote"

  # get "users/:id/destroy_old_guests" => "users#destroy_old_guests", :as => "destroy_old_guests"
  # map.resources :users, :collection => { :destroy_old_guests => :get}
  
  # match "/users/:id/promote" => "users#promote", via: :post
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
