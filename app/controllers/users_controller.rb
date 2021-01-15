class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:mypage, :edit, :update]
  before_action :correct_user_follower, only: :follower

  def mypage
    redirect_to user_path(current_user)
  end

  def index
    @users = User.all
  end

  def show
  end

  # def edit
  #   unless @user == current_user
  #     redirect_to user_path(@user)
  #   end
  # end

  # def update
  #   if current_user.update(user_params)
  #     flash[:alert] = '変更しました'
  #     redirect_to user_path(current_user)
  #   else
  #     flash[:alert] = '変更できませんでした'
  #     redirect_to edit_user_path(current_user)
  #   end
  # end

  def follow
    @follow_user = User.find(params[:id])
    @users = @follow_user.followings.order('relationships.created_at DESC').page(params[:page])
    if user_signed_in?
      @user = current_user
      @my_posts = Post.where(user_id: current_user.id).order('created_at DESC')
    end
  end

  def follower
    @follower_user = User.find(params[:id])
    @users = @follower_user.followers.order('relationships.created_at DESC').page(params[:page])
    if user_signed_in?
      @user = current_user
      @my_posts = Post.where(user_id: current_user.id).order('created_at DESC')
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.fetch(:user, {}).permit(:username)
    end

    def correct_user_follower
      redirect_to root_path unless user_signed_in? && params[:id] = current_user.id
    end
end
