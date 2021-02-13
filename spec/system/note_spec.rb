require 'rails_helper'

RSpec.describe Note, type: :system do
  describe "Noteモデルの検証や登録について" do
  let(:user_a) { create(:user, name: "ユーザーA", email: "a@au.com") }
  let(:user_b) { create(:user, name: "ユーザーB", email: "b@au.com") }
    context "ログイン状態のケース" do
      before do
        create(:note, name: "rspecテスト", user: user_a)
        create(:note, name: "system勉強", user: user_b)
        visit login_path
        fill_in "メールアドレス", with: login_user.email
        fill_in "パスワード", with: login_user.password
        click_button "ログインする"
      end

      context "ユーザーAがログインした時" do
        let(:login_user) { user_a }
        it "ユーザーAの作成したタスクが表示される" do
          expect(page).to have_content "rspecテスト"
        end
      end

      context "ユーザーBがログインした時" do
        let(:login_user) { user_b }
        it "ユーザーAのタスクは表示されない" do
          expect(page).to have_no_content "rspecテスト"
          expect(page).to have_content "system勉強"
        end

        it "ユーザーBが物理削除されたらタスクも消える" do
          expect( Proc.new {user_b.destroy}).to change{ Note.count }.by(-1)
        end
        it "ユーザーBが論理削除されたらタスクは残る" do
          expect( Proc.new {user_b.discard}).to change{ Note.count }.by(0)
        end
      end
      
    end
  end
end
