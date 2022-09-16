class PostGenreMap < ApplicationRecord

  # --------------------------------------------------
  # アソシエーション
  # --------------------------------------------------
  belongs_to :post
  belongs_to :genre

  # --------------------------------------------------
  # バリデーション
  # --------------------------------------------------
  validates :post_id, presence: true
  validates :genre_id, presence: true

end
