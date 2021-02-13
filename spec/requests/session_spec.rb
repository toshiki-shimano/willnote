require "rails_helper"

RSpec.describe "Session", type: :request do
  describe "sessionコントローラー" do
  let!(:new_user) { create(:user) }
  
    context "ログインにおいて" do
      
      it "ログイン画面の表示" do
        get "/login"
        expect(response).to have_http_status(200)
      end

      it "ログインしていない状態で他のページに行くとリダイレクトするか" do
        get "/notes"
        expect(response).to redirect_to login_path
      end
    
      it "登録されたユーザーがログインができるか" do
        sign_go(new_user)
        get notes_path
        expect(response).to have_http_status(200)
      end 
    end      
  end
end
