class PostTagMap < ApplicationRecord
  belongs_to :post
  belongs_to :tag

  # リレーションの際、それぞれのforeign keyは必須
  validates :post_id, presence: true
  validates :tag_id, presence: true
end
