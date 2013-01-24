class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :loc_id
      t.string :name
      t.integer :city
      t.integer :state
      t.string :country
      t.integer :zipcode
      t.decimal :lat
      t.decimal :long

      t.timestamps
    end
  end
end
