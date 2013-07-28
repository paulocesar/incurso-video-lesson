class CreateDescriptions < ActiveRecord::Migration
  def change
    create_table :descriptions do |t|
      t.string :name
      t.string :picture
      t.string :address
      t.string :phone
      t.text :information

      t.timestamps
    end
  end
end
