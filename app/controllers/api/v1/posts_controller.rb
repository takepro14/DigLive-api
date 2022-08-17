class Api::V1::PostsController < ApplicationController
  before_action :authenticate_active_user

  def index
    @posts = Post.all
    render json: @posts.as_json(include: :user)
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      render json: { status: 'SUCCESS', data: @post.as_json }
    else
      render json: { status: 'ERROR', data: @post.errors }
    end
  end

  private

    def post_params
      params.require(:post).permit(:user_id, :content)
    end

end
