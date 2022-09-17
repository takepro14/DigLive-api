class Post < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :user
  has_many :post_tag_maps, dependent: :destroy
  has_many :tags, through: :post_tag_maps
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_genre_maps, dependent: :destroy
  has_many :genres, through: :post_genre_maps
  has_many :notifications, dependent: :destroy

  validates :content, presence: true, length: { maximum: 300 }

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

end
