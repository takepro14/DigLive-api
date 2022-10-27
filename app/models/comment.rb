class Comment < ApplicationRecord

  ####################################################################################################
  # アソシエーション
  ####################################################################################################
  belongs_to :user
  belongs_to :post
  has_many :active_notifications, class_name: 'Notification', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', dependent: :destroy


  ####################################################################################################
  # バリデーション
  ####################################################################################################
  validates :comment, presence: true, length: { maximum: 300 }

  ####################################################################################################
  # インスタンスメソッド
  ####################################################################################################
  def create_notification_comment(visitor_id, post_id, comment_id)

    visitor = User.find(visitor_id)
    post = Post.find(post_id)
    notification = visitor.active_notifications.new(
      visitor_id: visitor_id,
      visited_id: post.user.id,
      post_id: post_id,
      comment_id: comment_id,
      action: 'comment'
    )

    if (notification.visitor_id != notification.visited_id) && (notification.valid?)
      notification.save
    end
  end
end
