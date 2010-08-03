# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090901204329) do

  create_table "boards", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "sla"
    t.text     "policy"
  end

  create_table "boards_users", :id => false, :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "board_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "card_histories", :force => true do |t|
    t.integer  "card_id",    :null => false
    t.integer  "column_id",  :null => false
    t.string   "action",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cards", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "column_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "type_id"
    t.integer  "parent_id"
    t.integer  "user_id"
    t.integer  "position"
    t.datetime "date_in_column"
  end

  create_table "cards_tags", :id => false, :force => true do |t|
    t.integer  "card_id",    :null => false
    t.integer  "tag_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "columns", :force => true do |t|
    t.string   "name"
    t.integer  "board_id",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.integer  "card_limit"
    t.text     "policy"
    t.float    "average_days_in_column"
  end

  create_table "tags", :force => true do |t|
    t.string   "name",       :default => "nil", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags_users", :id => false, :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "tag_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "types", :force => true do |t|
    t.integer  "board_id"
    t.string   "name"
    t.string   "hex_color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "mud_id",                               :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "show_search",       :default => false
    t.boolean  "show_type_legend",  :default => true
    t.boolean  "show_filter_cards", :default => true
  end

end
