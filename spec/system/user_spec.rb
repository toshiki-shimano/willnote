require 'rails_helper'

RSpec.describe User, type: :system do
  describe "Userモデルにおける検証や登録において" do
    let!(:user_a) { create(:user, name: "ユーザーA", email: "a@au.com", admin: true) }

    context "ユーザー登録において" do

      it "正しく登録されているか" do
        expect(user_a).to be_valid
      end

      it "同じメールアドレスの登録を防げるか" do
        @user_b = User.new(name: "ユーザーB", email: "a@au.com", password: "password2")
        expect(@user_b).not_to be_valid
      end

      it "名前が未入力の場合、エラーが起きて保存されない" do
        new_user = User.new
        expect(new_user).not_to be_valid
        expect(new_user.save).to eq false
      end

    end
    context "管理者（admin）のみ出来ることにおいて" do
      before do
        visit login_path
        fill_in "メールアドレス", with: user_a.email
        fill_in "パスワード", with: user_a.password
        click_button "ログインする"
      end

      it "ユーザー一覧が見える" do
        expect(page).to have_content "ユーザー一覧"
      end
    end
  end
end
