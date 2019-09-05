class AddColBook < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :count, :integer, default: 0
  end
end
