class UpdateTagsNullable < ActiveRecord::Migration
  def self.up
    change_column :tags, :name, :string, :null => false, :default => "nil"
    change_column :cards_tags, :card_id, :int, :null => false
    change_column :cards_tags, :tag_id, :int, :null => false
  end

  def self.down
    change_column :tags, :name, :int, :null => true, :default => nil
    change_column :cards_tags, :card_id, :int, :null => true
    change_column :cards_tags, :tag_id, :int, :null => true
  end
end
