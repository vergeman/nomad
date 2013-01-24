class ChangeUserIdColumnToUid < ActiveRecord::Migration
  def up
    rename_column :users, :user_id, :uid
  end

  def down
    rename_column :users, :uid, :user_id
  end

end
