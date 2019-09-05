class CreateBorrows < ActiveRecord::Migration[5.2]
  def change
    create_table :borrows do |t|
      t.date :start_date
      t.date :end_date
      t.integer :confirm, default: 0
      t.date :confirm_at
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :borrows, [:user_id, :book_id, :start_date, :end_date, :confirm], unique: true, name: :index_borrow
  end
end
