class Api::V1::CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: @comment
    end

  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

    def comment_params
      params.require(:comment).permit(:comment, :user_id, :post_id)
    end
end