FactoryBot.define do
  factory :post do
    sequence(:content) { |n| "テスト投稿#{n}です。" }
    youtube_url { "https://www.youtube.com/watch?v=0wF7P_UcET" }
    association :user
  end
end
