class Post < ApplicationRecord

  ##################################################
  # アソシエーション
  ##################################################
  belongs_to :user
  has_many :post_tag_maps, dependent: :destroy
  has_many :tags, through: :post_tag_maps
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_genre_maps, dependent: :destroy
  has_many :genres, through: :post_genre_maps
  has_many :notifications, dependent: :destroy

  ##################################################
  # オプション
  ##################################################
  default_scope -> { order(created_at: :desc) }

  ##################################################
  # バリデーション
  ##################################################
  validates :content, presence: true, length: { maximum: 300 }

  ##################################################
  # 新規投稿時のタグ保存
  ##################################################
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      # カテゴリのタグはユーザ作成可のためfind_or_created_by
      new_post_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_post_tag
    end
  end

  ##################################################
  # 新規投稿時のジャンル保存
  ##################################################
  def save_genre(sent_genres)
    current_genres = self.genres.pluck(:genre_name) unless self.genres.nil?
    old_genres = current_genres - sent_genres
    new_genres = sent_genres - current_genres

    old_genres.each do |old|
      self.genres.delete Genre.find_by(genre_name: old)
    end

    new_genres.each do |new|
      # ジャンルのタグはユーザ作成不可のためfind_byのみ
      new_post_genre = Genre.find_by(genre_name: new)
      self.genres << new_post_genre
    end
  end

  # ---------- コメントの通知 ----------
    def create_notification_comment!(current_user, comment_id)
      # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
      commented_user_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
      commented_user_ids.each do |commented_user_id|
        save_notification_comment!(current_user, comment_id, commented_user_id['user_id'])
      end
      # まだ誰もコメントしていない場合は、投稿者に通知を送る
      save_notification_comment!(current_user, comment_id, user_id) if commented_user_ids.blank?
    end

    def save_notification_comment!(current_user, comment_id, visited_id)
      # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
      notification = current_user.active_notifications.new(
        post_id: id,
        comment_id: comment_id,
        visited_id: visited_id,
        action: 'comment'
      )
      # 自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
end
