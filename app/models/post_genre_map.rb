class PostGenreMap < ApplicationRecord
  belongs_to :post
  belongs_to :genre

  validates :post_id, presence: true
  validates :genre_id, presence: true
end
