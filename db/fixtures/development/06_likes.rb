(1..15).each do |n|
  Like.seed do |s|
    s.user_id = rand(1..10)
    s.post_id = n
  end
end