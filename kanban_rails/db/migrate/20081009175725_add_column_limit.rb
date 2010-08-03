class AddColumnLimit < ActiveRecord::Migration
  def self.up
    add_column :columns, :card_limit, :integer, :null=>true
  end

  def self.down
    remove_column :columns, :card_limit
  end
end
