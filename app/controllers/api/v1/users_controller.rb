class Api::V1::UsersController < ApplicationController
  # 新規登録時は実行したくないのでexcept
  before_action :authenticate_active_user, except: [:create]

  def index
    users = User.all
    render json: users.as_json(include: [
                                { posts: { include: :user } },
                                :active_relationships,
                                :passive_relationships,
                              ])
  end

  def show
    @user = User.find(params[:id])
    render json: @user.as_json(include: [
                                { posts: { include: :user } },
                                :active_relationships,
                                :passive_relationships,
                                { likes: { include: { post: { include: :user } } } }
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

  def update
    # binding.pry
    @user = User.find(params[:id])
    @user.update(avatar: params[:avatar])

    if @user.save
      render json: @user
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
