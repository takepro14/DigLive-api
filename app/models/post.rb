class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tag_maps, dependent: :destroy
  has_many :tags, through: :post_tag_maps
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true, length: { maximum: 300 }

  def save_tag(sent_tags)
    # 現在タグの取得(edit: 既存タグ想定, new: タグなし想定)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    # 古いタグをDBから削除
    old_tags.each do |old|
      self.post_tags.delete PostTag.find_by(tag_name: old)
    end

    # 新しいタグをDBに保存
    new_tags.each do |new|
      new_post_tag = PostTag.find_or_create_by(tag_name: new)
      self.post_tags << new_post_tag
    end
  end
end
