Rails.application.routes.draw do
  # Devise routes
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Custom route for user registration
  devise_scope :user do
    post '/signup', to: 'users/registrations#create'
  end



  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # If you have a root route, uncomment the following line
  # root "home#index"
  
  # ... other routes ...
end
