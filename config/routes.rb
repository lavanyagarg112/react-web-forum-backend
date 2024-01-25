Rails.application.routes.draw do
  # ... other routes ...

  # Resources routes
  resource :user_datum, only: [:create, :update], controller: 'user_datum'
  resources :posts
  resources :tags

  # Nested resources routes for comments
  resources :posts do
    resources :comments do
      # Creating replies through a nested route
      resources :comments, path: 'replies'
    end
  end

  # Nested resources routes for favorites
  resources :posts do
    resources :favorites
    delete 'favorites', to: 'favorites#destroy'
  end

  # Custom routes
  get 'favorites', to: 'favorites#index'
  get 'favorites/check/:post_id', to: 'favorites#check', as: 'check_favorite'
  get 'users/:username/user_data', to: 'user_datum#profile'
  get 'users/:username/posts', to: 'posts#user_posts'

  # Devise routes
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Custom route for user registration
  devise_scope :user do
    post '/signup', to: 'users/registrations#create'
  end

  # Authentication routes
  get 'logged_in', to: 'authentication#logged_in'
  get '/current_user_data', to: 'user_datum#current_user_data'

  # Search route
  get 'search', to: 'posts#search'

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Root route
  root to: 'application#home'
end
