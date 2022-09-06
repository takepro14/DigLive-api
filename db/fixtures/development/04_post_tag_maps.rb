20.times do
  PostTagMap.seed do |s|
    s.post_id = rand(1..20)
    s.tag_id = rand(1..20)
  end
end