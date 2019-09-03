class ChangeColBorrow < ActiveRecord::Migration[5.2]
  def change
    rename_column :borrows, :confirm, :status
    rename_column :borrows, :confirm_at, :confirmed_at
  end
end
