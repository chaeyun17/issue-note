class Note < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  has_one_attached :photo
  has_rich_text :content
  acts_as_taggable_on :tags
  acts_as_commentable
  acts_as_votable
end
