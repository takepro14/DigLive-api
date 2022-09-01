30.times do
  Like.seed do |s|
    s.user_id = rand(1..30)
    s.post_id = rand(1..50)
  end
end