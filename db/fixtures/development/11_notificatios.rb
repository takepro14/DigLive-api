10.times do |t|
  # いいね
  Notification.seed do |s|
    s.visitor_id = t + 1
    s.visited_id = t + 2
    s.post_id = t + 1
    s.action = 'like'
  end
  # コメント
  Notification.seed do |s|
    s.visitor_id = t + 1
    s.visited_id = t + 2
    s.comment_id = t + 1
    s.action = 'comment'
  end
  # フォロー
  Notification.seed do |s|
    s.visitor_id = t + 1
    s.visited_id = t + 2
    s.post_id = t + 1
    s.action = 'follow'
  end
end