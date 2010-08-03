class UserGrantsOnUserTagsAndBoards < ActiveRecord::Migration
  def self.up
    if (RAILS_ENV == "preproduction" || RAILS_ENV == "production")
      execute "grant select on boards_users to kanban_read_role"
      execute "grant insert, update, delete on boards_users to kanban_write_role"
      execute "grant select on tags_users to kanban_read_role"
      execute "grant insert, update, delete on tags_users to kanban_write_role"
    end
  end

  def self.down
  end
end
