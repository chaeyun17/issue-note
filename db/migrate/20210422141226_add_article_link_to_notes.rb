class AddArticleLinkToNotes < ActiveRecord::Migration[6.1]
  def change
    add_column :notes, :article_link, :string
  end
end
