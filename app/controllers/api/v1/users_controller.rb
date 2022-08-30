class Api::V1::UsersController < ApplicationController
  # 新規登録時は実行したくないのでexcept
  before_action :authenticate_active_user, except: [:create]

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
    # binding.pry
    @user = User.new(user_params)
    if @user.save
      render json: @user.as_json(include: [
                                  { posts: { include: :user } },
                                  :active_relationships,
                                  :passive_relationships,
                                ])
    else
      render @user.errors.full_messages
    end
  end

  def destroy
  end

  private

  def user_params
    # TODO: activatedはメール認証にする
    params.require(:user).permit(:name, :email, :password, :avatar, :activated)
  end
end
