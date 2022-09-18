(1..15).each do |n|
  UserGenreMap.seed do |s|
    s.user_id = rand(1..10)
    s.genre_id = n + 1
  end
end