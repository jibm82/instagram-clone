# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.build(like_params)
    @post = @like.post

    if @like.save
      respond_to :js
    else
      flash[:alert] = 'Something went wrong'
    end
  end

  def destroy
    @like = current_user.likes.find_by_post_id(params[:post_id])
    @post = @like.post

    if @like.destroy
      render :create
    else
      flash[:alert] = 'Something went wrong'
    end
  end

  private

  def like_params
    params.permit :post_id
  end
end
