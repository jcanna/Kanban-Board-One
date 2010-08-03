class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.column :name, :string
      t.timestamps
    end
    create_table :cards_tags, :id => false do |t|
      t.column :card_id, :int
      t.column :tag_id, :int
      t.timestamps
    end
  end

  def self.down
    drop_table :cards_tags
    drop_table :tags
  end
end
