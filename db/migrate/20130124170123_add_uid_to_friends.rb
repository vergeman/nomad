class AddUidToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :uid, :bigint
  end
end
