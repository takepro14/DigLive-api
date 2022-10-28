30.times do
  Comment.seed do |s|
    s.user_id = rand(1..10)
    s.post_id = rand(1..15)
    s.comment = Faker::Lorem.paragraph
  end
end
