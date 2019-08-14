class CreateRelationshipAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :relationship_authors do |t|
      t.integer :author_f_id
      t.integer :user_f_id

      t.timestamps
    end
    add_index :relationship_authors, :author_f_id
    add_index :relationship_authors, :user_f_id
    add_index :relationship_authors, [:author_f_id, :user_f_id], unique: true
  end
end
