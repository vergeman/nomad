class ChangeDataTypeLocationCityStateToString < ActiveRecord::Migration
  def up
    change_table :locations do |l|
      l.change :city, :string
      l.change :state, :string
    end
  end

  def down
    change_table :locations do |l|
      t.change :city, :integer
      t.change :state, :integer
    end

  end
end
