class AddViewCountToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :notes, :view_count, :integer, default:0
  end
end
