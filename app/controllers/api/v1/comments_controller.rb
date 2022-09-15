class Api::V1::CommentsController < ApplicationController

  def create
    comment = Comment.new(comment_params)
    if comment.save
      comment.create_notification_comment(comment.user_id, comment.post_id, comment.id)
      render json: comment.as_json(include: [
                                      :user
                                    ])
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
  end

  private

    def comment_params
      params.require(:comment).permit(:comment, :user_id, :post_id)
    end
end
