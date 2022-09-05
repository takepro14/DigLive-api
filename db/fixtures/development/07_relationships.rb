10.times do |t|
  Relationship.seed do |s|
    s.follower_id = t + 1
    s.followed_id = t + 2
  end
end