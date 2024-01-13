Rails.application.routes.draw do


  # config/routes.rb
  resource :user_datum, only: [:create, :update], controller: 'user_datum'

  resources :posts
  resources :tags
  # resource :user do
  #   resource :user_datum, only: [:create, :update]
  # end
  
  resources :posts do
    resources :comments do
      # If you want to enable creating replies through a nested route
      resources :comments, path: 'replies'
      
    end
  end

  resources :posts do
    resources :favorites
    delete 'favorites', to: 'favorites#destroy'
    
  end

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

  # get 'logged_in', to: 'users#logged_in'
  get 'logged_in', to: 'authentication#logged_in'
  # config/routes.rb
  get '/current_user_data', to: 'user_datum#current_user_data'

  get 'search', to: 'posts#search'

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # If you have a root route, uncomment the following line
  # root "home#index"

  # match "*path", to: "application#fallback_index_html", via: :all
  
  # ... other routes ...
end
