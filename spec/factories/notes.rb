FactoryBot.define do
  factory :note do
    name { "rspecテスト" }
    memo1 { "system spec" }
    memo2 { "FactoryBot" }
    user
  end
end
