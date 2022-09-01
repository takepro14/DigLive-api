30.times do
  Comment.seed do |s|
    s.user_id = rand(1..30)
    s.post_id = rand(1..50)
    s.comment = Faker::Lorem.paragraph
  end
end