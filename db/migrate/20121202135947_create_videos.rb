class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.text :information
      t.float :price
      t.string :panda_video_id
      t.references :course
      t.references :user

      t.timestamps
    end
    add_index :videos, :course_id
    add_index :videos, :user_id
  end
end
