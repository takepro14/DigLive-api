30.times do
  Comment.seed do |s|
    s.user_id = rand(1..10)
    s.post_id = rand(1..20)
    s.comment = Faker::Lorem.paragraph
  end
end