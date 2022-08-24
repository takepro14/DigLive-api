20.times do
  PostTagMap.seed do |s|
    s.post_id = rand(1..10)
    s.tag_id = rand(1..30)
  end
end