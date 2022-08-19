(1..3).each do |id|
  PostTagMap.seed do |s|
    s.tag_id = id
    s.post_id = id
  end
end