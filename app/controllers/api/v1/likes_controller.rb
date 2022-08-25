class Api::V1::LikesController < ApplicationController

  def create
    @like = Like.new(like_params)
    @like.save
    render json: @like
  end

  def destroy
    @like = Like.find(like_params)
    @like.destroy
  end

  private

    def like_params
      params.require(:like).permit(:user_id, :post_id)
    end
end
