class Genre < ApplicationRecord

  has_many :post_genre_maps, dependent: :destroy, foreign_key: 'genre_id'
  has_many :user_genre_maps, dependent: :destroy, foreign_key: 'genre_id'
  has_many :posts, through: :post_genre_maps
  has_many :users, through: :user_genre_maps

end
