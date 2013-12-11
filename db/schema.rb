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

ActiveRecord::Schema.define(version: 20131210151223) do

  create_table "entries", force: true do |t|
    t.string   "title",                            null: false
    t.integer  "icon",       limit: 4, default: 0, null: false
    t.string   "login"
    t.string   "password",                         null: false
    t.string   "url"
    t.text     "comment"
    t.integer  "group_id",                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["group_id"], name: "index_entries_on_group_id"

  create_table "group_hierarchies", id: false, force: true do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "group_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "group_anc_desc_udx", unique: true
  add_index "group_hierarchies", ["descendant_id"], name: "group_desc_idx"

  create_table "groups", force: true do |t|
    t.string   "title",                            null: false
    t.integer  "icon",       limit: 4, default: 0, null: false
    t.integer  "sort_order"
    t.integer  "parent_id"
    t.integer  "user_id",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["parent_id"], name: "index_groups_on_parent_id"
  add_index "groups", ["user_id"], name: "index_groups_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
