class AddUserPrefs < ActiveRecord::Migration
  def self.up
    add_column :users, :show_search,      :boolean, :default => false;
    add_column :users, :show_type_legend, :boolean, :default => true;
  end

  def self.down
    remove_column :users, :show_search;
    remove_column :users, :show_type_legend;
  end
end
