class Api::V1::PostsController < ApplicationController
  before_action :authenticate_active_user
  include Pagination

  def index
    # ========== 個別処理 ==========
    # ----- /home: フォロータブ -----
    if params[:user_id]
      user = User.find(params[:user_id])
      followingPosts = user.following.map{|f| f.posts}.flatten
      posts = Kaminari.paginate_array(followingPosts).page(params[:page]).per(10)
    # ----- /users/id: 投稿タブ -----
    elsif params[:post_user_id]
      user = User.find(params[:post_user_id])
      userPosts = user.posts
      posts = Kaminari.paginate_array(userPosts).page(params[:page]).per(10)
    # ----- /users/id: いいねタブ -----
    elsif params[:like_user_id]
      user = User.find(params[:like_user_id])
      userLikes = user.likes.map {|like| like.post }
      posts = Kaminari.paginate_array(userLikes).page(params[:page]).per(10)
    # ----- /home: 最新タブ -----
    else
      posts = Post.all.page(params[:page]).per(10)
    end

    # ========== 共通処理 ==========
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

  def show
    @post = Post.find(params[:id])
    render json: @post.as_json(include: [
                                { user: { include: { passive_relationships: { only: :follower_id } } } },
                                :tags,
                                { comments: { include: :user } },
                                :likes,
                                :genres
                              ])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      render json: @post
    end
  end

  def search
    # ========== キーワード ==========
    if params[:post_keyword]
      posts = Post.search(params[:post_keyword]).includes([
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
    # ========== ジャンル ==========
    elsif params[:post_genre]
    # ========== タグ ==========
    elsif params[:post_tag]
    end
  end


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
