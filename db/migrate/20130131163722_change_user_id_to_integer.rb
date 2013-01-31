class ChangeUserIdToInteger < ActiveRecord::Migration
  def up
    change_column :friends, :user_id, :integer
  end

  def down
    change_column :friends, :user_id, :bigint
  end
end
