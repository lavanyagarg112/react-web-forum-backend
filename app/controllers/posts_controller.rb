class PostsController < ApplicationController

  before_action :set_post, only: [:edit, :update]

  def index
    posts = Post.includes(:tags).all
    render json: posts.as_json(include: :tags)
  end

    def create
      post = Post.new(post_params.except(:tag_ids, :new_tags))
      
    
      if post.save
        handle_tags(post, params[:tag_ids], params[:new_tags])
        render json: post, include: :tags, status: :created
      else
        render json: post.errors, status: :unprocessable_entity
      end
    end

    def show
      post = Post.includes(:tags).find_by(id: params[:id])
      if post
        render json: post.as_json(include: :tags)
      else
        render json: { error: "Post not found" }, status: :not_found
      end
    end

    def edit
      render json: @post, include: :tags
    end

    def update

      if @post.update(post_params.except(:tag_ids, :new_tags))
        handle_tags(@post, params[:tag_ids], params[:new_tags])
        render json: @post, include: :tags
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    def destroy
      post = Post.find(params[:id])
      if post.destroy
        render json: { message: 'Post was successfully deleted.' }, status: :ok
      else
        render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def post_params
      params.require(:post).permit(:title, :description, :author_name, :user_id, tag_ids: [], new_tags: [])
    end

    def set_post
      @post = Post.find(params[:id])
    end
    
    def handle_tags(post, tag_ids, new_tag_names)
      post.tags.clear if tag_ids.present? || new_tag_names.present?
      # Associate existing tags by IDs
      existing_tags = Tag.where(id: tag_ids)
      existing_tags.each do |tag|
        post.tags << tag unless post.tags.include?(tag)
      end
    
      # Create and associate new tags by names
      new_tag_names.each do |name|
        post.tags << Tag.find_or_create_by(name: name)
      end if new_tag_names.present?

      post.save
    end
    
  end
  