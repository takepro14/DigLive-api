30.times do
  Like.seed do |s|
    s.user_id = rand(1..15)
    s.post_id = rand(1..20)
  end
end