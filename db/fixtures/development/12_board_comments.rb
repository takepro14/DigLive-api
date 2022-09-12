30.times do
  BoardComment.seed do |s|
    s.user_id = rand(1..10)
    s.board_id = rand(1..20)
    s.comment = Faker::Lorem.paragraph
  end
end