FactoryBot.define do
  factory :post do
    sequence(:content) { |n| "テスト投稿#{n}です。" }
    association :user
  end
end
