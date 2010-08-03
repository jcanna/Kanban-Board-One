class AddColumnPolicy < ActiveRecord::Migration
  def self.up
    add_column :columns, :policy, :text, :null=>true
  end

  def self.down
    remove_column :columns, :policy
  end
end
