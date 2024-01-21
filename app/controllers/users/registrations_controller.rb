# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
  
    def create
      build_resource(sign_up_params)
      resource.save
      if resource.persisted?
        if resource.active_for_authentication?
          sign_up(resource_name, resource)
          token = JWT.encode({ user_id: resource.id }, ENV['SECRET_KEY_BASE'], 'HS256')
          render json: { message: 'Signed up successfully.', token: token }, status: :created
        else
          expire_data_after_sign_in!
          render json: { message: "Signed up successfully. Please verify your email." }, status: :ok
        end
      else
        clean_up_passwords(resource)
        set_minimum_password_length
        render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
      end
    
    rescue ActiveRecord::RecordNotUnique => e

        render json: { errors: { email: ["username/email has already been taken"] } }, status: :unprocessable_entity
    end
  
    private
  
    def sign_up_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
  end
  