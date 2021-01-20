class CommentsController < ApplicationController
    before_action :authenticate_user!  
    def create
        @post = Post.find(params[:post_id])
        @comment = current_user.comments.new(comment_params)
        if @comment.save
          flash[:notice] = 'コメントしました'
          @post.create_notification_comment!(current_user, @comment.id)
          redirect_back(fallback_location: root_path)
        else
          flash[:alert] = 'コメントできませんでした'
          redirect_back(fallback_location: root_path)
        end
    end

    def destroy
        @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
        if @comment.destroy
            flash[:notice] = 'コメントを削除しました'
            redirect_back(fallback_location: root_path)
        else
            flash.now[:alert] = 'コメント削除に失敗しました'
            redirect_back(fallback_location: root_path)
        end
    end
    
    private
    def comment_params
        params.require(:comment).permit(:content).merge(user_id: current_user.id, post_id: params[:post_id])
    end
end
