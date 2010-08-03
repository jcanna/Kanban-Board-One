class CreateUsersBoards < ActiveRecord::Migration
  def self.up
    create_table :users_boards do |t|
      t.column :user_id, :int
      t.column :board_id, :int
      t.timestamps
    end
  end

  def self.down
    drop_table :users_boards
  end
end
