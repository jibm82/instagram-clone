# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:photos, :likes, :comments)
    @saved_posts = Post.joins(:bookmarks).where(user: current_user).
      includes(:photos, :likes, :comments) if @user == current_user
  end
end
