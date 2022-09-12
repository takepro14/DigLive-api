class Api::V1::BoardCommentsController < ApplicationController

  def create
    @board = board.find(params[:board_id])
    @board_comment = @board.comments.create(comment_params)
    if @board_comment.save
      render json: @board_comment.as_json(include: [
                                            :user,
                                            :board
                                          ])
    end
  end

  def destroy
  end

  private

    def comment_params
      params.require(:comment).permit(:comment)
    end

end
