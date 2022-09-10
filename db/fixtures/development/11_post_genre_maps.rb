20.times do
  PostGenreMap.seed do |s|
    s.post_id = rand(1..20)
    s.genre_id = rand(1..20)
  end
end