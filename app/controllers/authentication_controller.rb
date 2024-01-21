# app/controllers/authentication_controller.rb
class AuthenticationController < ApplicationController
  # Assuming you have a method like 'authenticate_token' to validate JWT
  before_action :authenticate_token, only: [:logged_in]

  def logged_in
    if @current_user
      render json: { logged_in: true, user: @current_user.as_json(only: [:id, :email, :username]) }
    else
      render json: { logged_in: false }
    end
  end

  private

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
