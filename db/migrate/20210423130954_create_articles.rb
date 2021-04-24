class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :url
      t.string :title
      t.string :summary
      t.datetime :publishedAt
      t.string :press
      t.string :reporter

      t.timestamps
    end
  end
end
