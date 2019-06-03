# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: %w(show destroy)

  def index
    @post  = Post.new
    @posts = Post.paginate(page: params[:page], per_page: 5).includes(:photos, :user, :likes).
      order('created_at desc')
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      params[:images].each_pair do |key, _img|
        @post.photos.create(image: params[:images][key])
      end

      redirect_to posts_path, notice: 'Saved...'
    else
      redirect_to posts_path, alert: 'Something went wrong...'
    end
  end

  def show
    @comment = Comment.new
    @likes   = @post.likes.includes(:user)
    @photos  = @post.photos
  end

  def destroy
    if @post.user == current_user
      if @post.destroy
        flash[:notice] = 'Post deleted'
      else
        flash[:alert] = 'Something went wrong'
      end
    else
      flash[:alert] = "You don't have permission to do that!"
    end

    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find_by_id(params[:id])

    redirect_to posts_path, alert: 'Post not exists!' unless @post.present?
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
