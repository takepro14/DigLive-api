20.times do
  UserGenreMap.seed do |s|
    s.user_id = rand(1..10)
    s.genre_id = rand(1..20)
  end
end