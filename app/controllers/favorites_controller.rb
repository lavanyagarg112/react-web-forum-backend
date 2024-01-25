# app/controllers/favorites_controller.rb
class FavoritesController < ApplicationController
  before_action :authenticate_token

  # Create a favorite for a post.
  def create
    favorite = current_user.favorites.build(post_id: params[:post_id])
    if favorite.save
      render json: { status: 'success', favorite: favorite }, status: :created
    else
      render json: favorite.errors, status: :unprocessable_entity
    end
  end

  # Remove a post from favorites.
  def destroy
    favorite = current_user.favorites.find_by(post_id: params[:post_id])
    if favorite&.destroy
      head :no_content
    else
      render json: { error: 'Favorite not found' }, status: :not_found
    end
  end

  # List all posts marked as favorites by the current user.
  def index
    favorites = current_user.favorites.includes(:post)
    render json: favorites.map { |favorite| favorite.post }
  end

  # Check if a post is marked as a favorite by the current user.
  def check
    is_favorite = current_user.favorites.exists?(post_id: params[:post_id])
    render json: { is_favorite: is_favorite }
  end
end
