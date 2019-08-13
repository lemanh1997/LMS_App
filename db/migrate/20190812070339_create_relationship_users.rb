class CreateRelationshipUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :relationship_users do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :relationship_users, :follower_id
    add_index :relationship_users, :followed_id
    add_index :relationship_users, [:follower_id, :followed_id], unique: true
  end
end
