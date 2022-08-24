20.times do
  Post.seed do |s|
      s.user_id = rand(1..10)
      s.content = Faker::Lorem.paragraph
  end
end