
class Api::V1::RelationshipsController < ApplicationController
  before_action :set_user

  ####################################################################################################
  # フォロー作成
  ####################################################################################################
  def create
    current_user.follow(@other_user)
    @relationship = Relationship.find_by(followed_id: @other_user.id, follower_id: current_user.id)
    @relationship.create_notification_relationship(@relationship.followed_id, @relationship.follower_id)
    render json: @relationship
  end

  ####################################################################################################
  # フォロー削除
  ####################################################################################################
  def destroy
    current_user.unfollow(@other_user)
  end

  ####################################################################################################
  # プライベートメソッド
  ####################################################################################################
  private

    def set_user
      @other_user = User.find(params[:user_id])
    end

end
