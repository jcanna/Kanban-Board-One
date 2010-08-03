class CreateCards < ActiveRecord::Migration
  def self.up
    rename_table(:stories, :cards)
  end

  def self.down
    rename_table(:cards, :stories)
  end
end
