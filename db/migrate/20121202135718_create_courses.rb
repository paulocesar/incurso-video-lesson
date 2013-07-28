class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :information
      t.integer :discount
      t.references :area
      t.references :user

      t.timestamps
    end
    add_index :courses, :area_id
    add_index :courses, :user_id
  end
end
