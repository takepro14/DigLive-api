class Api::V1::RelationshipsController < ApplicationController
  before_action :set_user

  def create
    current_user.follow(@other_user)
    @relationship = Relationship.find_by(followed_id: @other_user.id, follower_id: current_user.id)
    render json: @relationship
  end

  def destroy
    current_user.unfollow(@other_user)
    @relationship = Relationship.find_by(followed_id: @other_user.id, follower_id: current_user.id)
  end

  private

    def set_user
      @other_user = User.find(params[:user_id])
    end

end
