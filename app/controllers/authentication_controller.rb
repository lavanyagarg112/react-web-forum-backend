# app/controllers/authentication_controller.rb
class AuthenticationController < ApplicationController
    def logged_in
      if user_signed_in?
        render json: { logged_in: true, user: current_user.as_json(only: [:id, :email, :username]) }
      else
        render json: { logged_in: false }
      end
    end
  end
  