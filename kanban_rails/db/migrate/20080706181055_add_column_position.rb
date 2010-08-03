class AddColumnPosition < ActiveRecord::Migration
  def self.up
    add_column :columns, :position, :integer;
  end

  def self.down
    remove_column :columns, :position;
  end
end
