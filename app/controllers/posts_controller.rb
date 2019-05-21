# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: :show

  def index
    @post  = Post.new
    @posts = Post.all.limit(10).includes(:photos)
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      params[:images].each do |img|
        @post.photos.create(image: img)
      end

      redirect_to posts_path, notice: 'Saved...'
    else
      redirect_to posts_path, alert: 'Something went wrong...'
    end
  end

  def show
    @photos = @post.photos
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
