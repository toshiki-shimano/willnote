class PostsController < ApplicationController
   before_action :login_required
   before_action :required_admin, only: %i(new create destroy)
   def home 
   end

   def profile
   end
   
   def index #今回は管理者しか投稿できないが少しでもDBの負担を減らすためにincludesをする
     @posts = Post.includes(:photos, :user).order(created_at: :desc).page(params[:page]).per(2)
   end
   
   def new
     @post = Post.new
     #postとphotoの関連付けにより記載。
     @post.photos.build
   end

   def create
     @post = current_user.posts.new(post_params)
      if @post.photos.present?
         @post.save
         redirect_to posts_path, notice: "投稿が保存されました"
      else
         flash.now[:alert] = "投稿に失敗しました" 
         render action: :new   
      end
   end

   def show
      @post = Post.find_by(id: params[:id])
   end

   def destroy
      @post = current_user.posts.find_by(id: params[:id])
      if @post.user == current_user
         @post.destroy
         redirect_to posts_path, notice: "投稿を削除しました"
      else 
         flash.now[:alert] = "削除に失敗しました"
         render :root
      end
   end

   private

   def post_params
      params.require(:post).permit(:caption, photos_attributes: [:image])
   end

   def login_required #カレントユーザーがtrueではない（ログインしていない）ユーザーは強制でログイン画面へ
      redirect_to login_path unless current_user
   end

   def required_admin
      redirect_to root_path unless current_user.admin?
   end
end
