class AddIndexToUserLevel < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :level
    add_column :users, :level, :integer, default: 0
  end
end
