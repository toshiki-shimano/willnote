require "rails_helper"

RSpec.describe Contact, type: :mailer do
    after { ActionMailer::Base.deliveries.clear } 
    let(:new_mail) { Contact.create(name: "test", email: "test@au.com", content: "日本語テスト") }
    let(:mail) { ContactMailer.received_email(new_mail)}

    it "メールが実際に送られているか" do
        expect do
            mail.deliver_now
        end.to change { ActionMailer::Base.deliveries.size }.by(1)
    end

    context "送られたメールの内容がきちんと取得できる(email_spec使用)" do #deilver_nowは必ずit内に記述する
        
      it "宛先へ送られている" do
          mail.deliver_now
          expect(open_last_email).to deliver_to(ENV["LOGIN_NAME"]) 
      end

      it "記入した件名が記載されている" do
          mail.deliver_now
          expect(open_last_email).to have_subject("【willnote】webサイトよりお問い合わせがありました") 
      end
      
      it "記入したメール内容が記載されている" do
          mail.deliver_now
          expect(open_last_email).to have_body_text(/日本語テスト/) 
      end
    end
end