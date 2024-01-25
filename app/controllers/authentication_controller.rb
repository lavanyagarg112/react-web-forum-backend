# app/controllers/authentication_controller.rb
class AuthenticationController < ApplicationController
  before_action :authenticate_token, only: [:logged_in]

  # Check if the user is logged in based on authentication token.
  def logged_in
    if @current_user
      render json: { logged_in: true, user: @current_user.as_json(only: [:id, :email, :username]) }
    else
      render json: { logged_in: false }
    end
  end
end
