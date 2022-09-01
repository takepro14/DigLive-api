class Api::V1::BoardsController < ApplicationController

  def index
    @boards = Board.all
    render json: @boards.as_json(include: [
                                  :user
                                ])
  end

  def show
    @board = Board.find(params[:id])
    render json: @board.as_json(include: [
                                  :user
                                ])
  end

end
