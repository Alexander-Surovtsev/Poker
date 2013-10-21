Poker::Application.routes.draw do
#  get "users/register"

#  get "users/confirm_registration"

#  get "tables/create"

#  get "confirm_create"
  
  get "t", to: "table#table"

  resource :sessions, only: [:new, :create, :destroy]
  
  resources :users
    
  get 'index', to: "poker#index"

  get "register", to: "users#register"

  post "confirm_registration_user", to: "users#confirm_registration"
  
  post "confirm_creation_table", to: "tables#confirm_creation_table"

#  get "poker/create_table"

#  get "poker/game"
  
  get 'signout', to: "poker#sign_out"
  
  match '/signin', to: 'sessions#new', via: 'get'
  
  match '/signup',  to: 'users#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  
  match '/notification', to: 'sessions#notification'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
