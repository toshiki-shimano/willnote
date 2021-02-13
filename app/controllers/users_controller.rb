class UsersController < ApplicationController
  before_action :required_admin, only: %i(index destroy)
  before_action :login_required, only: %i(edit update)

  def index
    @users = User.kept
    @disusers = User.with_discarded.discarded
  end

  def new #新規登録画面用
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path(@user), notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render action: :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.discard
    redirect_to users_path, notice: "ユーザー「#{@user.name}」を削除しました"
  end

  def edit #adminも一般ユーザーも変更可
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path, notice: "プロフィールを変更しました"
    else
      flash.now[:alert] = "変更に失敗しました"
      render action: :edit  
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
    
  end
  
  def required_admin
    redirect_to root_path unless current_user.admin?
  end

  def login_required 
    redirect_to login_path unless current_user
  end
end
