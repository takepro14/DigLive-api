FactoryBot.define do
  factory :comment do
    user { nil }
    post { nil }
    comment { "MyText" }
  end
end
