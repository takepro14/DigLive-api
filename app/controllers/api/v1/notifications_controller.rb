class Api::V1::NotificationsController < ApplicationController
  include Pagination

  ####################################################################################################
  # 通知一覧
  ####################################################################################################
  def index
    # binding.pry
    @user = User.find(current_user.id)
    notifications = @user.passive_notifications
                          .order(created_at: :desc)
                          .includes([
                            :visitor,
                            :visited,
                            :post,
                            :comment
                          ])
    notifications = Kaminari.paginate_array(notifications).page(params[:page]).per(10)
    pagination = resources_with_pagination(notifications)
    @notifications = notifications.as_json(include:[
                                            :visitor,
                                            :visited,
                                            { post: { include: :comments } }
                                          ])
    object = { notifications: @notifications, kaminari: pagination }
    render json: object
  end

  ####################################################################################################
  # 通知未読数取得
  ####################################################################################################
  def count_all
    @user = User.find(current_user.id)
    render :json => @user.passive_notifications.where(checked: false).length
  end

  ####################################################################################################
  # 通知全件更新(既読済にする)
  ####################################################################################################
  def update_all
    @user = User.find(current_user.id)
    if @user
      @user.passive_notifications.update_all checked: true
      @user.save
    end
  end

end
