class Api::V1::TasksController < ApplicationController

  # ヘルスチェック(ALB→ECSタスク(api))
  def index
    head 200
  end

  private
    # xhr_request?チェックをスキップする
    def check_xhr_request?
      false
    end

end
