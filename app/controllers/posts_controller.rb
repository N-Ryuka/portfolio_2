class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_post, only: [:edit, :update, :show, :delete]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @comment = Comment.new(post_id: @post.id)
    @comments = @post.comments
  end

  def new
    @post = Post.new
    @posts = Post.all
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: '投稿を削除しました'
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :cdategory, :body, :category_id)
    end
end
