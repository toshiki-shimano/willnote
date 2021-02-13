require "rails_helper"

RSpec.describe Post, type: :system, js: true do 
  describe "画像投稿に関する機能テスト" do
  let(:user_admin) { create(:user, admin: true, id: 1) } #admin用のボタン検証するためにidを設定
  let(:post_admin) { Post.create( caption: "test", user_id: user_admin.id, id: 10 )} #登録された画像を追うためにidを設定

    before  do
      @photo = Photo.create(
        image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/forest.jpg')),
        post_id: post_admin.id
      )
      visit login_path
      fill_in "メールアドレス", with: user_admin.email
      fill_in "パスワード", with: user_admin.password
      click_button "ログインする"
      click_link "管理人ブログ"
      find('.drawermark').click
      click_link "投稿一覧"
    end

    context "adminユーザーの画像登録において" do
      it "画像が登録されている" do
        expect(@photo.save).to be_truthy
      end

      it "いいねが出来ている" do 
        find('#like-icon-post-10').click
        expect(page).to have_content "いいね！"
      end

      it "コメントを書くと画面に現れる" do
        fill_in "20文字以内でコメント...", with: "テストしました"
        find('.send-comment').click
        expect(page).to have_content "テストユーザー：テストしました" #ここのコロンは全角にする
      end
    
      it "投稿画像が削除できる" do
        click_on "imgfield"
        click_link "削除"
        expect(@photo.destroy).to be_truthy
      end
    end

    context "他のユーザーは投稿できない" do
      before do
        @other = create(:user, email: "other@au.com")
        visit login_path
        fill_in "メールアドレス", with: @other.email
        fill_in "パスワード", with: @other.password
        click_button "ログインする"
      end
      it "投稿リンクを発見できない" do
        click_link "管理人ブログ"
        expect(page).to have_no_content "投稿する"
      end

      it "投稿画面を開いてもリダイレクトされる" do
        click_link "管理人ブログ"
        expect(Proc.new {visit new_post_path}).to change {current_path}.from(adminhome_path).to(root_path)
      end
    end
  end
end