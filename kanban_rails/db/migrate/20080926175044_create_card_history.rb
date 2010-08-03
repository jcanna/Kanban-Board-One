class CreateCardHistory < ActiveRecord::Migration
  def self.up
    create_table :card_histories do |t|
      t.column :card_id, :int
      t.column :column_id, :int
      t.column :action, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :card_histories
  end
end
