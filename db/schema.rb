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

ActiveRecord::Schema.define(version: 20151008182511) do

  create_table "broadcasts", force: :cascade do |t|
    t.string   "title",             null: false
    t.string   "short_description"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",                         null: false
    t.string   "color",      default: "white"
    t.boolean  "admin_only", default: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "categories_broadcasts", id: false, force: :cascade do |t|
    t.integer "category_id",  null: false
    t.integer "broadcast_id", null: false
  end

  add_index "categories_broadcasts", ["broadcast_id"], name: "index_categories_broadcasts_on_broadcast_id"
  add_index "categories_broadcasts", ["category_id"], name: "index_categories_broadcasts_on_category_id"

  create_table "categories_users", id: false, force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "user_id",     null: false
  end

  add_index "categories_users", ["category_id"], name: "index_categories_users_on_category_id"
  add_index "categories_users", ["user_id"], name: "index_categories_users_on_user_id"

  create_table "events", force: :cascade do |t|
    t.string   "title",      null: false
    t.datetime "start_time", null: false
    t.datetime "end_time",   null: false
    t.string   "google_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events_attendees", id: false, force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "user_id",  null: false
  end

  add_index "events_attendees", ["event_id"], name: "index_events_attendees_on_event_id"
  add_index "events_attendees", ["user_id"], name: "index_events_attendees_on_user_id"

  create_table "guest_lectures", force: :cascade do |t|
    t.integer  "users_id",          null: false
    t.string   "title",             null: false
    t.string   "short_description"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "guest_lectures", ["users_id"], name: "index_guest_lectures_on_users_id"

  create_table "notes", force: :cascade do |t|
    t.integer  "users_id",                     null: false
    t.string   "note",                         null: false
    t.string   "color",      default: "white"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "notes", ["users_id"], name: "index_notes_on_users_id"

  create_table "users", force: :cascade do |t|
    t.string   "password_digest", null: false
    t.string   "name",            null: false
    t.string   "email",           null: false
    t.string   "type",            null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
