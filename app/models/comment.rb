class Comment < ApplicationRecord

  # --------------------------------------------------
  # アソシエーション
  # --------------------------------------------------
  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy

  # --------------------------------------------------
  # バリデーション
  # --------------------------------------------------
  validates :comment, presence: true, length: { maximum: 300 }

  # --------------------------------------------------
  # メソッド
  # --------------------------------------------------
  def create_notification_comment(visitor_id, post_id, comment_id)
    visitor = User.find(visitor_id)
    post = Post.find(post_id)
    notification = visitor.active_notifications.new(
      visitor_id: visitor.id,
      visited_id: post.user.id,
      post_id: post_id,
      comment_id: comment_id,
      action: 'comment'
    )

    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
