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


  
end
