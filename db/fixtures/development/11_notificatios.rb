5.times do |t|
  # フォロー
  Notification.seed do |s|
    s.action = 'follow'
    s.visitor_id = t + 1
    s.visited_id = t + 2
  end
  # いいね
  Notification.seed do |s|
    s.action = 'like'
    s.visitor_id = t + 1
    s.visited_id = t + 2
    s.post_id = t + 1
  end
  # コメント
  Notification.seed do |s|
    s.action = 'comment'
    s.visitor_id = t + 1
    s.visited_id = t + 2
    s.post_id = t + 1
    s.comment_id = t + 1
  end
end