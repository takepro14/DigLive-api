class Api::V1::LikesController < ApplicationController

  ##################################################
  # いいね作成
  ##################################################
  def create
    @like = Like.new(like_params)

    if @like.save
      @like.create_notification_like(@like.user_id, @like.post_id)
      render status: :created, json: @like
    end

  end

  ##################################################
  # いいね解除
  ##################################################
  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    render json: @like
    # render status: :success
  end

  ##################################################
  # プライベートメソッド
  ##################################################
  private

    def like_params
      params.require(:like).permit(:user_id, :post_id)
    end
end
