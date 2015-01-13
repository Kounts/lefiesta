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

ActiveRecord::Schema.define(version: 20150109145446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "_events_users", id: false, force: true do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.text     "note"
    t.string   "web"
    t.string   "email"
    t.string   "phone"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["event_id"], name: "index_contacts_on_event_id", using: :btree

  create_table "event_users", id: false, force: true do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  add_index "event_users", ["event_id"], name: "index_event_users_on_event_id", using: :btree
  add_index "event_users", ["user_id"], name: "index_event_users_on_user_id", using: :btree

  create_table "events", force: true do |t|
    t.string   "title"
    t.string   "theme"
    t.date     "date"
    t.string   "location"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "users_id"
    t.string   "pinterest"
  end

  create_table "guests", force: true do |t|
    t.string   "name"
    t.boolean  "mandatory",  default: false
    t.boolean  "attending"
    t.text     "note"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "guests", ["event_id"], name: "index_guests_on_event_id", using: :btree

  create_table "shopping_items", force: true do |t|
    t.string   "name"
    t.integer  "quantity"
    t.boolean  "bought",     default: false
    t.text     "note"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shopping_items", ["event_id"], name: "index_shopping_items_on_event_id", using: :btree

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.date     "deadline"
    t.boolean  "done",       default: false
    t.text     "note"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "tasks", ["event_id"], name: "index_tasks_on_event_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",                            null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
