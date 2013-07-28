class CreateUsersVideosTable < ActiveRecord::Migration
  def up
    create_table :users_videos, :id => false do |t|
        t.references :user
        t.references :video
    end
    add_index :users_videos, [:user_id, :video_id]
    add_index :users_videos, [:video_id, :user_id]
  end

  def down
    drop_table :users_videos
  end
end
