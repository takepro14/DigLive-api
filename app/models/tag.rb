class Tag < ApplicationRecord

  has_many :post_tag_maps, dependent: :destroy
  has_many :posts, through: :post_tag_maps

  # タグで投稿を検索
  def self.tag_search_posts(tag)
    tag = self.find_by(tag_name: tag)
    tag.posts
  end

end
