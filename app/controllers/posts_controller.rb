class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to new_post_path
    else
      render :new
    end
  end

  def new
    @post = Post.new
    @posts = Post.all
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
