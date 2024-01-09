Rails.application.routes.draw do


  # config/routes.rb
  resource :user_datum, only: [:create, :update], controller: 'user_datum'

  resources :posts
  resources :tags
  # resource :user do
  #   resource :user_datum, only: [:create, :update]
  # end
  

  # Devise routes
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Custom route for user registration
  devise_scope :user do
    post '/signup', to: 'users/registrations#create'
  end

  # get 'logged_in', to: 'users#logged_in'
  get 'logged_in', to: 'authentication#logged_in'
  # config/routes.rb
  get '/current_user_data', to: 'user_datum#current_user_data'


  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # If you have a root route, uncomment the following line
  # root "home#index"

  
  # ... other routes ...
end
