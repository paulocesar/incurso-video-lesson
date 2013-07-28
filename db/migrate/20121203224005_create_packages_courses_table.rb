class CreatePackagesCoursesTable < ActiveRecord::Migration
  def up
    create_table :packages_courses, :id => false do |t|
        t.references :package
        t.references :course
    end
    add_index :packages_courses, [:package_id, :course_id]
    add_index :packages_courses, [:course_id, :package_id]
  end

  def down
    drop_table :packages_courses
  end
end
