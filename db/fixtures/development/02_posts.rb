(1..10).each do |n|
  Post.seed do |s|
    s.user_id = n
    s.content = "ユーザID:#{n}の投稿です。"
  end
end