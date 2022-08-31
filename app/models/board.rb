class Board < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 200 }
end
