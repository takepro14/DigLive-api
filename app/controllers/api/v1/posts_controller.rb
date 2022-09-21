class Api::V1::PostsController < ApplicationController
  before_action :authenticate_active_user
  include Pagination

  def index
    # フォロータブ
    if params[:user_id]
      user = User.find(params[:user_id])
      followingPosts = user.following.map{|f| f.posts}.flatten

      posts = Kaminari.paginate_array(followingPosts).page(params[:page]).per(10)
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

    # 最新タブ
    else
      posts = Post.all.page(params[:page]).per(10)
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
