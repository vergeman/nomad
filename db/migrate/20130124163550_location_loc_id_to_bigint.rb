class LocationLocIdToBigint < ActiveRecord::Migration
  def up
    change_column :users, :uid, :bigint
    change_column :locations, :loc_id, :bigint
    change_column :friends, :user_id, :bigint
  end


  def down
    change_column :users, :uid, :integer
    change_column :locations, :loc_id, :integer
    change_column :friends, :user_id, :integer
  end
end
