class UserDatumController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @user_data = current_user.build_user_datum(user_data_params)
      if @user_data.save
        render json: @user_data, status: :created
      else
        render json: @user_data.errors, status: :unprocessable_entity
      end
    end
  
    def update
      @user_data = current_user.user_datum
      puts "hiiiii"
      if @user_data.update(user_data_params)
        current_user.posts.update_all(author_name: @user_data.authorname)
        current_user.comments.update_all(author_name: @user_data.authorname)
        render json: @user_data
      else
        render json: @user_data.errors, status: :unprocessable_entity
      end
    end

    def current_user_data
        render json: current_user.user_datum
      end
  
    private
  
    def user_data_params
      params.require(:user_data).permit(:authorname)
    end
  end
  