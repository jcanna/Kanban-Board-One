class RenameOwnerColumns < ActiveRecord::Migration
  def self.up
    rename_column "boards", "owner_id", "user_id" 
    rename_column "cards", "owner_id", "user_id" 
  end

  def self.down
    rename_column "boards", "user_id", "owner_id" 
    rename_column "cards", "user_id", "owner_id" 
  end
end
