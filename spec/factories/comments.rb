FactoryBot.define do
  factory :comment do
    sequence(:comment) { |n| "テストコメント#{n}です。" }
    association :user, :post
  end
end
