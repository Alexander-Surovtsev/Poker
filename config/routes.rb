Poker::Application.routes.draw do
  get "tables", to: "tables#index"
  get "table", to: "tables#table"

  resource :sessions, only: [:new, :create, :destroy]
  
  resources :users
    
  get '', to: "poker#index"
      
  get 'index', to: "poker#index"

  get "register", to: "users#register"

  post "confirm_registration_user", to: "users#confirm_registration"
  
  post "confirm_creation_table", to: "tables#confirm_creation_table"

  get 'signout', to: "poker#sign_out"
  
  match '/signin', to: 'sessions#new', via: 'get'
  
  match '/signup',  to: 'users#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  
  get '/notification', to: 'sessions#notification'
  
  ##########
  ##########
  ##########
  match '/send_message', to: 'tables#process_message'
  
  match '/get_messages', to: 'tables#get_messages'
  ##########
  ##########
  ##########
end
