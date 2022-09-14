class Api::V1::NotificationsController < ApplicationController

  ##################################################
  # 通知全件取得
  ##################################################
  def index
    # binding.pry
    @user = User.find(current_user.id)
    @notifications = @user.passive_notifications.includes(:visitor, :visited, :post, :comment)

    render json: @notifications.as_json(include:[
                                            :visitor,
                                            :visited,
                                            :post,
                                            :comment
                                          ]
                                        )
  end

end
