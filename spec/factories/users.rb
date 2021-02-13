FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    email { "test@au.com" }
    password { "password" }
  end
end
