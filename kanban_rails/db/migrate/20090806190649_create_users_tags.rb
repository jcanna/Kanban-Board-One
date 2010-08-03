class CreateUsersTags < ActiveRecord::Migration
  def self.up
    create_table :users_tags do |t|
      t.column :user_id, :int
      t.column :tag_id, :int
      t.timestamps
    end    
  end

  def self.down
    drop_table :users_tags
  end
end
