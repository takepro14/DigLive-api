class Api::V1::LikesController < ApplicationController

  def create
    @like = Like.new(like_params)
    @like.save
    render json: @like
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    render json: @like
    # render status: :success
  end

  private

    def like_params
      params.require(:like).permit(:user_id, :post_id)
    end
end
