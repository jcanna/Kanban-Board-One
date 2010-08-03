class ShowFilteredCards < ActiveRecord::Migration
  def self.up
    add_column :users, :show_filter_cards, :boolean, :default => true
  end

  def self.down
    remove_column :users, :show_filter_cards
  end
end
