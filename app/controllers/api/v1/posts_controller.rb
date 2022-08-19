class Api::V1::PostsController < ApplicationController
  before_action :authenticate_active_user

  def index
    # @tag_list = Tag.all
    @posts = Post.all
    # include xxxはアソシエーションが単数or複数に合わせる
    render json: @posts.as_json(include: [
                                  { user: { only: :name } },
                                  :tags
                                ])
  end

  def create
    @post = Post.new(post_content_params)
    sent_tags = post_tag_params[:tags] === nil ? [] : post_tag_params[:tags]

    if @post.save
      @post.save_tag(sent_tags)
      render json: @post.as_json(include: [
                                  { user: { only: :name } },
                                  :tags
                                ])
    else
      render json: { status: 'ERROR', data: @post.errors }
    end
  end

  private

    def post_content_params
      params.require(:post).permit(:user_id, :content)
    end

    def post_tag_params
      params.require(:post).permit(:tags)
    end

end
