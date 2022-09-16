class Api::V1::TagsController < ApplicationController

  # --------------------------------------------------
  # タグ一覧の表示
  # --------------------------------------------------
  def index
    @tags = Tag.all
    render json: @tags
  end

end
