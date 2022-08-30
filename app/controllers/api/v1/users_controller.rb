class Api::V1::UsersController < ApplicationController
  # ログイン済みのユーザしかアクセスさせたくないリソースに設定
  before_action :authenticate_active_user

  def index
    users = User.all
    render json: users.as_json(only: [:id, :name, :email, :created_at])
    # render json: current_user.as_json(only: [:id, :name, :email, :created_at])
  end

  def show
    @user = User.find(params[:id])
    render json: @user.as_json(include: [
                                { posts: { include: :user } },
                                :active_relationships,
                                :passive_relationships,
                              ])
  end

  def create
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :avatar)
  end
end
