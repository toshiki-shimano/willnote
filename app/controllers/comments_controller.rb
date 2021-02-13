class CommentsController < ApplicationController
    before_action :login_required
    
    def create
        @comment = Comment.new(comment_params)
        @post = @comment.post
        if @comment.save
            respond_to :js
        else
            flash.now[:alert] = "コメントに失敗しました"
        end
    end

    def destroy
        @comment = Comment.find_by(id: params[:id])
        @post = @comment.post
        if @comment.destroy
            respond_to :js
        else
           flash[:alert] = "コメントの削除に失敗しました"
        end
    end

    private

    def comment_params
        params.required(:comment).permit(:user_id, :post_id, :comment)
    end

    def login_required #カレントユーザーがtrueではない（ログインしていない）ユーザーは強制でログイン画面へ
        redirect_to login_path unless current_user
    end
end
