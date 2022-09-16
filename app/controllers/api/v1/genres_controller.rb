class Api::V1::GenresController < ApplicationController

  # --------------------------------------------------
  # ジャンル一覧の表示
  # --------------------------------------------------
  def index
    @genres = Genre.all
    render json: @genres
  end

end
