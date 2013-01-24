class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :user_id
      t.string :name
      t.integer :current_location_id
      t.integer :hometown_location_id

      t.timestamps
    end
  end
end
