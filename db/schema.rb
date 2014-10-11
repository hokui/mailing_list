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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141011133406) do

  create_table "archives", force: true do |t|
    t.integer  "list_id",                 null: false
    t.integer  "number",                  null: false
    t.string   "from",                    null: false
    t.string   "subject",    default: "", null: false
    t.text     "text",       default: "", null: false
    t.text     "html",       default: "", null: false
    t.text     "raw",        default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", force: true do |t|
    t.integer  "archive_id",     null: false
    t.string   "name",           null: false
    t.string   "type",           null: false
    t.text     "content_base64", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["archive_id"], name: "index_attachments_on_archive_id"

  create_table "lists", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lists", ["name"], name: "index_lists_on_name", unique: true

  create_table "lists_members", id: false, force: true do |t|
    t.integer "list_id",   null: false
    t.integer "member_id", null: false
  end

  add_index "lists_members", ["list_id", "member_id"], name: "index_lists_members_on_list_id_and_member_id", unique: true

  create_table "members", force: true do |t|
    t.string   "name",                    null: false
    t.string   "email",                   null: false
    t.string   "email_sub",  default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["email"], name: "index_members_on_email", unique: true
  add_index "members", ["email_sub"], name: "index_members_on_email_sub"

end
