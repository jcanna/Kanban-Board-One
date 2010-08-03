class AddUserGrants < ActiveRecord::Migration
  def self.up
=begin
    if (RAILS_ENV == "preproduction" || RAILS_ENV == "production")
      execute "grant select on users to kanban_read_role"
      execute "grant insert, update, delete on users to kanban_write_role"
      execute "grant select on users_seq to kanban_read_role"
    end
=end
  end

  def self.down
  end
end
