class LikesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post, only: [:create, :destroy]

    def create
        @like = current_user.likes.create(post_id: params[:post_id])
        redirect_back(fallback_location: root_path)
    end 

    def destroy
        like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
        like.destroy
        redirect_back(fallback_location: root_path)
    end

    private

    def set_post
        @post = Post.find(params[:post_id])
    end

end
