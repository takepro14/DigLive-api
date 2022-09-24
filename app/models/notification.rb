class Notification < ApplicationRecord
  # default_scope -> { order(created_at: :desc) }

  ####################################################################################################
  # アソシエーション
  ####################################################################################################
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
  belongs_to :post, optional: true
  belongs_to :comment, optional: true

  ####################################################################################################
  # バリデーション
  ####################################################################################################
  validates :visitor, presence: true
  validates :visited, presence: true

end
