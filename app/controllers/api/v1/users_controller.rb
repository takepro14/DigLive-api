class Api::V1::UsersController < ApplicationController
  # 新規登録時は実行したくないのでexcept
  before_action :authenticate_active_user, except: [:create]

  def index
    users = User.includes(:posts)
    render json: users.as_json(include: [
                                { posts: { include: [:user, :likes] } },
                                :active_relationships,
                                :passive_relationships,
                                :genres,
                                { likes: { include: { post: { include: :user } } } }
                              ])
  end

  def show
    @user = User.find(params[:id])
    render json: @user.as_json(include: [
                                { posts: { include: [:user, :likes] } },
                                :active_relationships,
                                :passive_relationships,
                                :genres,
                                { likes: { include: { post: { include: :user  } } } }
                              ])
  end

  def create
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
    @user = User.find(params[:id])
    @user.update(user_params)
    sent_genres = user_genre_params[:genres] === nil ? [] : user_genre_params[:genres]

    if @user.save
      @user.save_genres(sent_genres)
      render json: @user.as_json(include: [
                                  :posts,
                                  :active_relationships,
                                  :passive_relationships,
                                  :genres,
                                  { likes: { include: :post } }
                                ])
    end
  end

  # TODO: 実装予定
  def destroy
  end


  private

  def user_params
    # TODO: activatedはメール認証にする
    params.require(:user).permit(:name, :email, :password, :profile, :avatar, :activated)
  end

  def user_genre_params
    params.require(:user).permit(genres: [])
  end
end
