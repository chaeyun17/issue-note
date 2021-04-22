class AddArticleInfoToNotes < ActiveRecord::Migration[6.1]
  def change
    add_column :notes, :article_info, :string
  end
end
