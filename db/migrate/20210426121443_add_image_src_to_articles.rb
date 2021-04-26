class AddImageSrcToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :imageSrc, :string
  end
end
