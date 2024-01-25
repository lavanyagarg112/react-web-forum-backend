# app/controllers/user_data_controller.rb
class UserDatumController < ApplicationController
  before_action :authenticate_token, except: [:profile]

  # Create user data for the current user.
  def create
    @user_data = current_user.build_user_datum(user_data_params)
    if @user_data.save
      render json: @user_data, status: :created
    else
      render json: @user_data.errors, status: :unprocessable_entity
    end
  end

  # Update user data for the current user.
  def update
    @user_data = current_user.user_datum
    if @user_data.update(user_data_params)
      current_user.posts.update_all(author_name: @user_data.authorname)
      current_user.comments.update_all(author_name: @user_data.authorname)
      render json: @user_data
    else
      render json: @user_data.errors, status: :unprocessable_entity
    end
  end

  # Get the user data for the current user.
  def current_user_data
    if current_user
      render json: current_user.user_datum
    else
      render json: { error: 'Not authenticated' }, status: :unauthorized
    end
  end

  # Show user data for a specific user by username.
  def show
    user = User.find_by(username: params[:username])
    user_data = user.user_datum

    if user_data
      render json: user_data
    else
      render json: { error: 'User data not found' }, status: :not_found
    end
  end

  # Show user profile data for a specific user by username.
  def profile
    user = User.find_by(username: params[:username])
    user_data = user.user_datum

    if user_data
      render json: user_data
    else
      render json: { error: 'User data not found' }, status: :not_found
    end
  end

  private

  # Define permitted parameters for user data creation/update.
  def user_data_params
    params.require(:user_data).permit(:authorname, :bio)
  end
end
