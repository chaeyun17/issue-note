class Note < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  has_one_attached :photo
  has_rich_text :content
  has_many :comments
end
