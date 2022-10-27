class Api::V1::CommentsController < ApplicationController

  ####################################################################################################
  # コメント作成
  ####################################################################################################
  def create
    comment = Comment.new(comment_params)
    if comment.save
      comment.create_notification_comment(comment.user_id, comment.post_id, comment.id)
      render json: comment.as_json(include: [
                                      :user
                                    ])
    end
  end

  ####################################################################################################
  # コメント削除
  ####################################################################################################
  def destroy
    comment = Comment.find(params[:id])
    render json: comment.as_json(include: [
                                  :user
                                ])
    comment.destroy
  end


  ####################################################################################################
  # プライベートメソッド
  ####################################################################################################
  private

    def comment_params
      params.require(:comment).permit(:comment, :user_id, :post_id)
    end
end
