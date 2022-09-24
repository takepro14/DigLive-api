class Api::V1::PostsController < ApplicationController
  before_action :authenticate_active_user
  include Pagination

  ####################################################################################################
  # 投稿一覧
  ####################################################################################################
  def index
    # ---------- /home/投稿/フォロー ----------
    if params[:user_id]
      user = User.find(params[:user_id])
      followingPosts = user.following
                            .includes({
                              posts: [
                                { user: :passive_relationships },
                                :tags,
                                { comments: :user},
                                :likes,
                                :genres
                              ]
                            })
                            .map(&:posts).flatten
                            .sort{|a,b| b[:created_at] <=> a[:created_at]}
      posts = Kaminari.paginate_array(followingPosts).page(params[:page]).per(10)

    # ---------- /users/id/投稿 ----------
    elsif params[:post_user_id]
      user = User.find(params[:post_user_id])
      userPosts = user.posts
                      .order(created_at: "DESC")
                      .includes([
                        { user: :passive_relationships },
                        :tags,
                        { comments: :user},
                        :likes,
                        :genres
                      ])
      posts = Kaminari.paginate_array(userPosts).page(params[:page]).per(10)

    # ---------- /users/id/いいね ----------
    elsif params[:like_user_id]
      user = User.find(params[:like_user_id])
      userLikes = user.liked_posts
                      .order(created_at: "DESC")
                      .includes([
                        { user: :passive_relationships },
                        :tags,
                        { comments: :user},
                        :likes,
                        :genres
                      ])
      posts = Kaminari.paginate_array(userLikes).page(params[:page]).per(10)

    # ---------- /home/投稿/最新 ----------
    else
      allPosts = Post.order(created_at: "DESC")
                      .includes([
                        { user: :passive_relationships },
                        :tags,
                        { comments: :user},
                        :likes,
                        :genres
                      ])
      posts = Kaminari.paginate_array(allPosts).page(params[:page]).per(10)
    end

    # ---------- 共通 ----------
    pagination = resources_with_pagination(posts)
    @posts = posts.as_json(include: [
                            { user: { include: { passive_relationships: { only: :follower_id } } } },
                            :tags,
                            { comments: { include: :user } },
                            :likes,
                            :genres
                          ])
    object = { posts: @posts, kaminari: pagination }
    render json: object
  end

  ####################################################################################################
  # 投稿作成
  ####################################################################################################
  def create
    @post = Post.new(post_content_params)
    sent_tags = post_tag_params[:tags] === nil ? [] : post_tag_params[:tags]
    sent_genres = post_genre_params[:genres] === nil ? [] : post_genre_params[:genres]

    if @post.save
      @post.save_tag(sent_tags)
      @post.save_genre(sent_genres)
      render json: @post.as_json(include: [
                                  { user: { include: { passive_relationships: { only: :follower_id } } } },
                                  :tags,
                                  :genres
                                ])
    else
      render json: { status: 'ERROR', data: @post.errors }
    end
  end

  ####################################################################################################
  # 投稿詳細
  ####################################################################################################
  def show
    @post = Post.includes([
                  { user: :passive_relationships },
                  :tags,
                  { comments: :user },
                  :likes,
                  :genres
                ])
                .find(params[:id])
    render json: @post.as_json(include: [
                                { user: { include: { passive_relationships: { only: :follower_id } } } },
                                :tags,
                                { comments: { include: :user } },
                                :likes,
                                :genres
                              ])
  end

  ####################################################################################################
  # 投稿削除
  ####################################################################################################
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      render json: @post
    end
  end

  ####################################################################################################
  # 投稿検索
  ####################################################################################################
  def search
    # ==================================================
    # キーワード検索
    # ==================================================
    if params[:post_keyword]
      # タイミングにより空パラメータの時に検索されてしまう事象の回避
      return if params[:post_keyword] == ''
      posts = Post.keyword_search_posts(params[:post_keyword])
                  .order(created_at: "DESC")
                  .includes([
                    { user: :passive_relationships },
                    :tags,
                    { comments: :user},
                    :likes,
                    :genres
                  ])
      render json: posts.as_json(include: [
                                  { user: { include: { passive_relationships: { only: :follower_id } } } },
                                  :tags,
                                  { comments: { include: :user } },
                                  :likes,
                                  :genres
                                ])
    # ==================================================
    # ジャンル検索
    # ==================================================
    elsif params[:post_genre]
      return if params[:post_genre] == ''
      posts = Genre.genre_search_posts(params[:post_genre])
                    .order(created_at: "DESC")
                    .includes([
                      { user: :passive_relationships },
                      :tags,
                      { comments: :user},
                      :likes,
                      :genres
                    ])
      render json: posts.as_json(include: [
                                  { user: { include: { passive_relationships: { only: :follower_id } } } },
                                  :tags,
                                  { comments: { include: :user } },
                                  :likes,
                                  :genres
                                ])
    # ==================================================
    # タグ検索
    # ==================================================
    elsif params[:post_tag]
      return if params[:post_tag] == ''
      posts = Tag.tag_search_posts(params[:post_tag])
                  .order(created_at: "DESC")
                  .includes([
                    { user: :passive_relationships },
                    :tags,
                    { comments: :user},
                    :likes,
                    :genres
                  ])
      render json: posts.as_json(include: [
                                  { user: { include: { passive_relationships: { only: :follower_id } } } },
                                  :tags,
                                  { comments: { include: :user } },
                                  :likes,
                                  :genres
                                ])
    end
  end

  ####################################################################################################
  # プライベートメソッド
  ####################################################################################################
  private

    def post_content_params
      params.require(:post).permit(:user_id, :youtube_url, :content)
    end

    def post_tag_params
      params.require(:post).permit(tags: [])
    end

    def post_genre_params
      params.require(:post).permit(genres: [])
    end

end
