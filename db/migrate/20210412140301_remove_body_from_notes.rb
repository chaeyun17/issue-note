class RemoveBodyFromNotes < ActiveRecord::Migration[6.1]
  def change
    remove_column :notes, :body, :string
  end
end
