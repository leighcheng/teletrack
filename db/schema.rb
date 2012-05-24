# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120220194343) do

  create_table "components", :force => true do |t|
    t.string   "component_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.integer  "ticket_id"
    t.integer  "staff_id"
    t.text     "note_text",  :limit => 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["staff_id"], :name => "staff_id"
  add_index "notes", ["ticket_id"], :name => "ticket_id"

  create_table "priorities", :force => true do |t|
    t.string   "priority_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schema_info", :id => false, :force => true do |t|
    t.integer "version"
  end

  create_table "staffs", :force => true do |t|
    t.string   "name",            :limit => 100
    t.string   "hashed_password", :limit => 40
    t.string   "email",           :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_hash"
    t.string   "password_salt"
  end

  create_table "statuses", :force => true do |t|
    t.string   "status_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", :force => true do |t|
    t.integer  "type_id"
    t.integer  "component_id"
    t.integer  "priority_id"
    t.integer  "status_id"
    t.integer  "created_id"
    t.integer  "assigned_id"
    t.text     "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tickets", ["assigned_id"], :name => "assigned_id"
  add_index "tickets", ["component_id"], :name => "component_id"
  add_index "tickets", ["created_id"], :name => "created_id"
  add_index "tickets", ["priority_id"], :name => "priority_id"
  add_index "tickets", ["status_id"], :name => "status_id"
  add_index "tickets", ["type_id"], :name => "type_id"

  create_table "types", :force => true do |t|
    t.string   "type_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
