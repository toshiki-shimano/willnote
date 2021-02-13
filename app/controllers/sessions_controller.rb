class SessionsController < ApplicationController
  before_action :login_required, only: %i(destroy)
  
  def new
  end

  def create
    @user = User.find_by(email: session_params[:email])

    if @user&.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: "ログインに成功しました。"
    else
      flash.now[:alert] = "ログインに失敗しました"
      render action: :new
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: "ログアウトしました。"
  end

  private
  
  def session_params
    params.require(:session).permit(:email, :password)
  end

  def login_required #カレントユーザーがtrueではない（ログインしていない）ユーザーは強制でログイン画面へ
    redirect_to login_path unless current_user
  end
end
