(1..10).each do |n|
  Post.seed do |s|
    s.user_id = n
    s.content = Faker::Lorem.paragraph
  end
end