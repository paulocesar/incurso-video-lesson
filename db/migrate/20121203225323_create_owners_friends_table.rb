class CreateOwnersFriendsTable < ActiveRecord::Migration
  def up
    create_table :owners_friends, :id => false do |t|
        t.references :owner
        t.references :friend
    end
    add_index :owners_friends, [:owner_id, :friend_id]
    add_index :owners_friends, [:friend_id, :owner_id]
  end

  def down
    drop_table :owners_friends
  end
end
