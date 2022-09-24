class Api::V1::NotificationsController < ApplicationController

  ####################################################################################################
  # 通知一覧
  ####################################################################################################
  def index
    @user = User.find(current_user.id)
    @notifications = @user.passive_notifications.includes(:visitor, :visited, :post, :comment)

    render json: @notifications.as_json(include:[
                                            :visitor,
                                            :visited,
                                            { post: { include: :comments } }
                                          ]
                                        )
  end

end
