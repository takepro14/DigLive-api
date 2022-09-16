class UserGenreMap < ApplicationRecord

  # --------------------------------------------------
  # アソシエーション
  # --------------------------------------------------
  belongs_to :user
  belongs_to :genre

  # --------------------------------------------------
  # バリデーション
  # --------------------------------------------------
  validates :user_id, presence: true
  validates :genre_id, presence: true

end
