class UpdateBoardPolicy < ActiveRecord::Migration
  def self.up
    remove_column :boards, :policy
    add_column :boards, :policy, :text
  end

  def self.down
  end
end
