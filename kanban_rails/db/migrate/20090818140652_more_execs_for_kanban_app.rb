class MoreExecsForKanbanApp < ActiveRecord::Migration
  def self.up
    change_column :boards_users,  :board_id, :int,  :null => false
    change_column :boards_users,  :user_id,  :int,   :null => false
    change_column :tags_users,    :tag_id,   :int,   :null => false
    change_column :tags_users,    :user_id,  :int,   :null => false
    change_column :card_histories,:card_id,  :int,   :null => false
    change_column :card_histories,:column_id,:int,  :null => false
    change_column :card_histories,:action,   :string,  :null => false
  end

  def self.down
  end
end
