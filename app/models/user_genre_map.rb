class UserGenreMap < ApplicationRecord

  belongs_to :user
  belongs_to :genre

  validates :user_id, presence: true
  validates :genre_id, presence: true
  validates :user_id, uniqueness: { scope: :genre_id }

end
