(1..15).each do |n|
  PostGenreMap.seed do |s|
    s.post_id = n
    s.genre_id = n + 1
  end
end