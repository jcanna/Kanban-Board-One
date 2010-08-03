class AddBoardSla < ActiveRecord::Migration
  def self.up
    add_column :boards, :sla, :integer
  end

  def self.down
    remove_column :boards, :sla
  end
end
