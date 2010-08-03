class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.column :name, :string
      t.column :description, :text
      t.column :column_id, :integer, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
