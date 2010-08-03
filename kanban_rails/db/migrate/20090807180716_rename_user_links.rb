class RenameUserLinks < ActiveRecord::Migration
  def self.up
    rename_table :users_boards, :boards_users
    rename_table :users_tags, :tags_users
  end

  def self.down
    rename_table :boards_users, :users_boards 
    rename_table :tags_users, :users_tags 
  end
end
