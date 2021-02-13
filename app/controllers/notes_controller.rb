class NotesController < ApplicationController
  before_action :login_required
  before_action :set_note, only: %i(show edit update destroy)


  def index
    @notes = current_user.notes.order(created_at: :desc)
  end

  def new
    @note = Note.new
  end

  def create #関連とマイグレでuser_idがnullがfalseで設定したので、そのuser_idが入ってないと登録できない
    @note = current_user.notes.new(note_params)
    if @note.save
      redirect_to :root, notice: "ノート「#{@note.name}」を登録しました。"
    else
      flash.now[:alert] = "登録に失敗しました"
      render action: :new
    end
  end

  def show
    #set_note
  end

  def edit
    #set_note
  end

  def update
    #set_note
    if @note.update(note_params)
      redirect_to :root, notice: "ノート「#{@note.name}」を更新しました。"
    else
      render action: :edit
    end
  end

  def destroy
    #set_note
    if @note.destroy
      redirect_to :root, notice: "ノート「#{@note.name}」を削除しました。"
    else
      flash.now[:alert] = "削除に失敗しました"
      render :root
    end
  end



  private

  def note_params
    params.require(:note).permit(:name, :memo1, :memo2)
  end

  def login_required #カレントユーザーがtrueではない（ログインしていない）ユーザーは強制でログイン画面へ
    redirect_to login_path unless current_user
  end

  def set_note #情報の取得をカレントユーザーに限定する
    @note = current_user.notes.find(params[:id])
  end
end
