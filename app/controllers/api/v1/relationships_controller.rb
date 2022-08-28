class Api::V1::RelationshipsController < ApplicationController
  before_action :set_user

  def create
    # binding.pry
    current_user.follow(@other_user)
    render json: @other_user
  end

  def destroy
    current_user.unfollow(@other_user)
    render json: @other_user
  end

  private

    def set_user
      @other_user = User.find(params[:user_id])
    end
end
