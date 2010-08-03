class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :mud_id, :string, :null => false, :unique => true
      t.column :first_name, :string
      t.column :last_name, :string
      t.timestamps
    end
    add_column :boards, :owner_id, :int
    add_column :boards, :policy, :string
    add_column :cards, :owner_id, :int
  end

  def self.down
    drop_table :users
    remove_column :boards, :owner_id
    remove_column :boards, :policy
    remove_column :cards, :owner_id
  end
end
