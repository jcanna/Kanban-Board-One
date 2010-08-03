class CreateColumns < ActiveRecord::Migration
  def self.up
    create_table :columns do |t|
      t.column :name, :string
      t.column :board_id, :integer, :null => false  
      t.timestamps
    end
  end

  def self.down
    drop_table :columns
  end
end
