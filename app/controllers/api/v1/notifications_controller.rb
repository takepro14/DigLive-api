class Api::V1::NotificationsController < ApplicationController

  ####################################################################################################
  # 通知一覧
  ####################################################################################################
  def index
    @user = User.find(current_user.id)
    @notifications = @user.passive_notifications.includes(:visitor, :visited, :post, :comment)
    # @notifications.where(checked: false).each{|notification| notification.update_attributes(checked: true)}

    render json: @notifications.as_json(include:[
                                            :visitor,
                                            :visited,
                                            { post: { include: :comments } }
                                          ]
                                        )
  end

  ####################################################################################################
  # 通知全件更新(既読済にする)
  ####################################################################################################
  def update_all
    @user = User.find(current_user.id)
    @user.passive_notifications.update_all checked: true
    @user.save
  end

end
