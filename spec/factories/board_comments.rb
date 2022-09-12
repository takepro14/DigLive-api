FactoryBot.define do
  factory :board_comment do
    comment { "MyText" }
    board { nil }
    user { nil }
  end
end
