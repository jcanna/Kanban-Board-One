class RemoveLinkIdKey < ActiveRecord::Migration
  def self.up
    remove_column "boards_users", "id"
    remove_column "tags_users", "id"
  end

  def self.down
    add_column "boards_users", "id"
    add_column "tags_users", "id"
  end
end
