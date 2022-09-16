class Like < ApplicationRecord

  # --------------------------------------------------
  # アソシエーション
  # --------------------------------------------------
  belongs_to :user
  belongs_to :post

  # --------------------------------------------------
  # メソッド
  # --------------------------------------------------
  def create_notification_like(visitor_id, post_id)
    # 通知生成済みかどうかチェックする
    notification_like = Notification.where(["visitor_id = ? and post_id = ? and action = ? ", visitor_id, post_id, 'like'])

    # 通知生成済みではない時のみ生成する
    if notification_like.blank?
      visitor = User.find(visitor_id)
      post = Post.find(post_id)
      notification = visitor.active_notifications.new(
        visitor_id: visitor.id,
        visited_id: post.user.id,
        post_id: post_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

end
