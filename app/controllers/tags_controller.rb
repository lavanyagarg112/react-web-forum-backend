# app/controllers/tags_controller.rb
class TagsController < ApplicationController
  # List all tags.
  def index
    tags = Tag.all
    render json: tags
  end

  # Create a new tag.
  def create
    tag = Tag.new(tag_params)
    if tag.save
      render json: tag, status: :created
    else
      render json: tag.errors, status: :unprocessable_entity
    end
  end

  private

  # Define permitted parameters for tag creation.
  def tag_params
    params.require(:tag).permit(:name)
  end
end
