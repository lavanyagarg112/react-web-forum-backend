# app/controllers/favorites_controller.rb
class FavoritesController < ApplicationController
    before_action :authenticate_token
  
    def create
      favorite = current_user.favorites.build(post_id: params[:post_id])
      if favorite.save
        render json: { status: 'success', favorite: favorite }, status: :created
      else
        render json: favorite.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      favorite = current_user.favorites.find_by(post_id: params[:post_id])
      if favorite&.destroy
        head :no_content
      else
        render json: { error: 'Favorite not found' }, status: :not_found
      end
    end
  
    def index
      favorites = current_user.favorites.includes(:post)
      render json: favorites.map { |favorite| favorite.post }
    end

    def check
        is_favorite = current_user.favorites.exists?(post_id: params[:post_id])
        puts "hi"
        puts is_favorite
        render json: { is_favorite: is_favorite }
      end
  end
  