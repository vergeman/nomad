class ChangeDataTypeForFbIdsToBigint < ActiveRecord::Migration
  def up
    change_table :users do |u|
      u.change :uid, :bigint
    end

    change_table :locations do |l|
      l.change :loc_id, :bigint
    end

    change_table :friends do |f|
      f.change :user_id, :bigint
    end

  end

  def down
    change_table :users do |u|
      u.change :uid, :integer
    end

    change_table :locations do |l|
      l.change :loc_id, :integer
    end

    change_table :friends do |f|
      f.change :user_id, :integer
    end

  end
end
