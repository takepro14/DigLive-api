class Api::V1::BoardsController < ApplicationController

  def index
    @boards = Board.all
    render json: @boards.as_json(include: [
                                  :user
                                ])
  end

end
