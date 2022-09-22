class Api::V1::UsersController < ApplicationController
  # 新規登録時は実行したくないのでexcept
  before_action :authenticate_active_user, except: [:create]
  include Pagination

  ####################################################################################################
  # ユーザー一覧
  ####################################################################################################
  def index
    # ========== 個別処理 ==========
    # /home: フォロータブ
    if params[:user_id]
      user = User.find(params[:user_id])
      followingUsers = user.following.includes(:posts)
      users = Kaminari.paginate_array(followingUsers).page(params[:page]).per(10)
      pagination = resources_with_pagination(users)

    # /home: 最新タブ
    else
      users_tmp = User.includes(:posts)
      # includeで配列になるのでpaginate_arrayを噛ませる
      users =  Kaminari.paginate_array(users_tmp).page(params[:page]).per(10)
      pagination = resources_with_pagination(users)
    end

    # ========== 共通処理 ==========
    @users = users.as_json(include: [{
                                  posts: {
                                    include: [
                                      { user: { include: :passive_relationships } },
                                      { comments: { include: :user } },
                                      :likes,
                                      :tags,
                                      :genres
                                    ]
                                  }
                                },
                                  :active_relationships,
                                  :passive_relationships,
                                  :genres
                                ])
      object = { users: @users, kaminari: pagination }
      render json: object
  end

  ####################################################################################################
  # ユーザー詳細
  ####################################################################################################
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

  ####################################################################################################
  # ユーザー作成
  ####################################################################################################
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

  ####################################################################################################
  # ユーザー更新
  ####################################################################################################
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

  ####################################################################################################
  # ユーザー削除
  ####################################################################################################
  # TODO: 実装予定
  def destroy
  end

  ####################################################################################################
  # ユーザー検索
  ####################################################################################################
  def search
    # ========== キーワード検索 ==========
    if params[:user_keyword]
      return if params[:user_keyword] == ''
      users = User.keyword_search_users(params[:user_keyword]).includes([
                                                                        { posts: [
                                                                          { user: :passive_relationships },
                                                                          { comments: :user },
                                                                          :likes,
                                                                          :tags,
                                                                          :genres
                                                                          ]
                                                                        },
                                                                        :active_relationships,
                                                                        :passive_relationships,
                                                                        :genres
                                                                      ])
      render json: users.as_json(include: [{
                                            posts: {
                                              include: [
                                                { user: { include: :passive_relationships } },
                                                { comments: { include: :user } },
                                                :likes,
                                                :tags,
                                                :genres
                                              ]
                                            }
                                          },
                                            :active_relationships,
                                            :passive_relationships,
                                            :genres
                                          ])
    # ========== ジャンル検索 ==========
    elsif params[:user_genre]
      return if params[:user_genre] == ''
      users = Genre.genre_search_users(params[:user_genre]).includes([
                                                                        { posts: [
                                                                          { user: :passive_relationships },
                                                                          { comments: :user },
                                                                          :likes,
                                                                          :tags,
                                                                          :genres
                                                                          ]
                                                                        },
                                                                        :active_relationships,
                                                                        :passive_relationships,
                                                                        :genres
                                                                      ])
      render json: users.as_json(include: [{
                                            posts: {
                                              include: [
                                                { user: { include: :passive_relationships } },
                                                { comments: { include: :user } },
                                                :likes,
                                                :tags,
                                                :genres
                                              ]
                                            }
                                          },
                                            :active_relationships,
                                            :passive_relationships,
                                            :genres
                                          ])
    end
  end

  ####################################################################################################
  # プライベートメソッド
  ####################################################################################################
  private

  def user_params
    # TODO: activatedはメール認証にする
    params.require(:user).permit(:name, :email, :password, :profile, :avatar, :activated)
  end

  def user_genre_params
    params.require(:user).permit(genres: [])
  end
end
