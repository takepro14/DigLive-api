class Relationship < ApplicationRecord

  # --------------------------------------------------
  # アソシエーション
  # --------------------------------------------------
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  # --------------------------------------------------
  # バリデーション
  # --------------------------------------------------
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  # --------------------------------------------------
  # メソッド
  # --------------------------------------------------
  # フォローの通知作成
  def create_notification_relationship(visited_id, visitor_id)
    notification_follow = Notification.where(["visited_id = ? and visitor_id = ? and action = ? ", visited_id, visitor_id, 'follow'])
    if notification_follow.blank?
      visitor = User.find(visitor_id)
      notification = visitor.active_notifications.new(
        visitor_id: visitor_id,
        visited_id: visited_id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
