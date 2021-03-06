class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_post, only: [:edit, :update, :show, :destroy, :like]

  def index
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all.order(created_at: :desc)
    @posts = @posts.page(params[:page]).per(10)
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

  def new
    @post = Post.new
    @tags = Tag.all
  end

  # @posts = Post.all

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = '投稿しました'
      redirect_to posts_path
    else
      flash[:notice] = '投稿できませんでした'
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @comment = Comment.new(post_id: @post.id)
    @comments = @post.comments
    @like_count = Like.where(post_id: @post.id).count
  end


  def destroy
    @post.destroy
    redirect_to root_path, notice: '投稿を削除しました'
  end

  def like
    @liked_post = Post.find(params[:id])
    @users = @liked_post.liked_users.order('likes.created_at DESC').page(params[:page])
    if user_signed_in?
      @user = current_user
      @my_posts = Post.where(user_id: current_user.id).order('created_at DESC')
    end
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :category_id, :body, tag_ids: [])
    end
end
