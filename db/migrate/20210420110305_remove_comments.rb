class RemoveComments < ActiveRecord::Migration[6.1]
  def change
    drop_table :comments do |t|
      t.string :body
      t.string :author
      t.references :note, null: false, foreign_key: true

      t.timestamps
    end
  end
end
