class LikesController < ApplicationController
    before_action :login_required

    def create
        @like = current_user.likes.build(like_params)
        @post = @like.post
        if @like.save
            respond_to :js
        end
    end

    def destroy
        @like = Like.find_by(id: params[:id])
        @post = @like.post
        if @like.destroy
            respond_to :js
        end
    end

    private

    def like_params
        params.permit(:post_id)
    end

    def login_required #カレントユーザーがtrueではない（ログインしていない）ユーザーは強制でログイン画面へ
        redirect_to login_path unless current_user
    end
end
