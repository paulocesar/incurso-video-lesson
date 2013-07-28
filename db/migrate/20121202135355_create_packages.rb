class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.text :information
      t.integer :discount
      t.references :user

      t.timestamps
    end
    add_index :packages, :user_id
  end
end
