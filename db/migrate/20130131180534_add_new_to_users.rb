class AddNewToUsers < ActiveRecord::Migration
  def change
    add_column :users, :new, :boolean
  end
end
