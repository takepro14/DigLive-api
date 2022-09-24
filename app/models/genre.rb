class Genre < ApplicationRecord

  ####################################################################################################
  # アソシエーション
  ####################################################################################################
  has_many :post_genre_maps, dependent: :destroy, foreign_key: 'genre_id'
  has_many :user_genre_maps, dependent: :destroy, foreign_key: 'genre_id'
  has_many :posts, through: :post_genre_maps
  has_many :users, through: :user_genre_maps

  ####################################################################################################
  # インスタンスメソッド
  ####################################################################################################
  # ジャンルで投稿を検索
  def self.genre_search_posts(genre)
    genre = self.find_by(genre_name: genre)
    genre.posts
  end

  # ジャンルでユーザーを検索
  def self.genre_search_users(genre)
    genre = self.find_by(genre_name: genre)
    genre.users
  end

end
