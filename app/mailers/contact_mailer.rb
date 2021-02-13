class ContactMailer < ApplicationMailer
  def received_email(user)
    @user = user
    mail from: @user.email,
         to: ENV["LOGIN_NAME"], #自身にお問い合わせが来るように設定
         subject: "【willnote】webサイトよりお問い合わせがありました"
  end
end
