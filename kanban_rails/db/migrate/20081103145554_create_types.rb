class CreateTypes < ActiveRecord::Migration
  def self.up
    create_table :types do |t|
      t.column :board_id, :int
      t.column :name, :string
      t.column :hex_color, :string
      t.timestamps
    end
    add_column :cards, :type_id, :int
  end

  def self.down
    drop_table :types
    remove_column :cards, :type_id
  end
end
