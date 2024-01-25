# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::StrongParameters
  include ActionController::Cookies

  before_action :configure_permitted_parameters, if: :devise_controller?

  # A sample action for the root URL to provide a welcome message.
  def home
    render json: { message: "Welcome to my API" }
  end

  protected

  # Configure permitted parameters for user sign-up and account update.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  private

  # Authenticate user based on JWT token in the request header.
  def authenticate_token
    # Extract the token from the request header
    token = request.headers['Authorization']&.split(' ')&.last

    if token
      begin
        decoded_token = JWT.decode(token, ENV['SECRET_KEY_BASE'], true, { algorithm: 'HS256' })
        @current_user = User.find(decoded_token[0]['user_id'])
      rescue JWT::DecodeError
        # Handle the case where the token is invalid
        @current_user = nil
      end
    else
      @current_user = nil
    end
  end
end
