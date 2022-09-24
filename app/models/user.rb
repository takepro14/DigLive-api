require "validator/email_validator"
class User < ApplicationRecord

  ####################################################################################################
  # アソシエーション
  ####################################################################################################
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent:   :destroy
  has_many :user_genre_maps, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  # 間接
  has_many :genres, through: :user_genre_maps
  has_many :liked_posts, through: :likes, source: :post
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  ####################################################################################################
  # バリデーション
  ####################################################################################################
  before_validation :downcase_email
  validates :name, presence: true,
        length: {
          maximum: 30,
          allow_blank: true
        }
  validates :email, presence: true,
        email: { allow_blank: true }
        # TODO: 後から追加
        # uniqueness: { case_sensitive: false }
  # 「a-zA-Z0-9_-」に一致する8文字以上
  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  validates :password, presence: true,
              length: {
                minimum: 8,
                allow_blank: true
              },
              format: {
                with: VALID_PASSWORD_REGEX,
                message: :invalid_password,
                allow_blank: true
              },
              allow_nil: true

  ####################################################################################################
  # モジュール等
  ####################################################################################################
  include TokenGenerateService
  mount_uploader :avatar, AvatarUploader
  has_secure_password

  ####################################################################################################
  # クラスメソッド
  ####################################################################################################
  class << self
    def find_by_activated(email)
      find_by(email: email, activated: true)
    end

    def keyword_search_users(keyword)
      where("name LIKE?", "%#{keyword}%").or(where("profile LIKE?", "%#{keyword}%"))
    end

    # キーワードでユーザーを検索
  end

  ####################################################################################################
  # インスタンスメソッド
  ####################################################################################################
  def save_genres(sent_genres)
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

  # 自分以外の同じemailのアクティブなユーザーがいる場合にtrueを返す
  def email_activated?
    users = User.where.not(id: id)
    users.find_by_activated(email).present?
  end

  # リフレッシュトークンのJWT IDを記憶する
  def remember(jti)
    update!(refresh_jti: jti)
  end

  # リフレッシュトークンのJWT IDを削除する
  def forget
    update!(refresh_jti: nil)
  end

  # ユーザオブジェクトの共通のJSONレスポンスを返す(キーの型を統一)
  def response_json(payload = {})
    as_json(only: [:id, :name]).merge(payload).with_indifferent_access
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  ####################################################################################################
  # プライベートメソッド
  ####################################################################################################
  private

    def downcase_email
      self.email.downcase! if email
    end
end
