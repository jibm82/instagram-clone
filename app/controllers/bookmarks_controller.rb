# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)

    if @bookmark.save
      @post = @bookmark.post

      respond_to :js
    else
      flash[:alert] = 'Something went wrong...'
    end
  end

  def destroy
    @bookmark = current_user.bookmarks.find_by_post_id(params[:post_id])
    @post = @bookmark.post

    if @bookmark.destroy
      render :create
    else
      flash[:alert] = 'Something went wrong...'
    end
  end

  private

  def bookmark_params
    params.permit(:post_id)
  end
end
