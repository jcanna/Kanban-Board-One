class AddParentToCards < ActiveRecord::Migration
  def self.up
    add_column :cards, :parent_id, :integer, :null=>true
  end

  def self.down
    remove_column :cards, :parent_id
  end
end
