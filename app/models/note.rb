class Note < ApplicationRecord
  has_one_attached :photo
  has_rich_text :content
end
