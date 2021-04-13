class Note < ApplicationRecord
  validates :title, presence: true
  has_one_attached :photo
  has_rich_text :content
  has_many :comments
end
