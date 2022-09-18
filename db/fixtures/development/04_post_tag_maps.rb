(1..15).each do |n|
  PostTagMap.seed do |s|
    s.post_id = n
    s.tag_id = n
    s.tag_id = n + 1
  end
end