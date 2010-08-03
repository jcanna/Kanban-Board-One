class Addaveragedaysincolumn < ActiveRecord::Migration
  def self.up
     add_column :columns, :average_days_in_column, :float
  end

  def self.down
    remove_column :columns, :average_days_in_column
  end
end
