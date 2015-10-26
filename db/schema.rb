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

ActiveRecord::Schema.define(version: 20151026002234) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "broadcasts", force: :cascade do |t|
    t.text     "title",                      null: false
    t.text     "description",                null: false
    t.boolean  "active",      default: true, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "calendars", force: :cascade do |t|
    t.text     "name",               null: false
    t.text     "google_calendar_id", null: false
    t.text     "token"
    t.text     "access_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "calendars_users", id: false, force: :cascade do |t|
    t.integer "calendar_id", null: false
    t.integer "user_id",     null: false
  end

  add_index "calendars_users", ["calendar_id"], name: "index_calendars_users_on_calendar_id", using: :btree
  add_index "calendars_users", ["user_id"], name: "index_calendars_users_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.citext   "name",                          null: false
    t.text     "description"
    t.boolean  "user_related",                  null: false
    t.boolean  "topic_related",                 null: false
    t.boolean  "admin_only",    default: true,  null: false
    t.boolean  "approved",      default: false, null: false
    t.boolean  "hidden",        default: false, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "categories", ["admin_only"], name: "index_categories_on_admin_only", using: :btree
  add_index "categories", ["hidden"], name: "index_categories_on_hidden", using: :btree
  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree
  add_index "categories", ["topic_related"], name: "index_categories_on_topic_related", using: :btree
  add_index "categories", ["user_related"], name: "index_categories_on_user_related", using: :btree

  create_table "category_joins", force: :cascade do |t|
    t.integer  "category_id",        null: false
    t.string   "categorizable_type", null: false
    t.integer  "categorizable_id",   null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "category_joins", ["categorizable_id", "categorizable_type"], name: "index_category_joins_on_categorizable_id_and_categorizable_type", using: :btree
  add_index "category_joins", ["category_id"], name: "index_category_joins_on_category_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.text     "title",                            null: false
    t.text     "description"
    t.text     "location"
    t.datetime "start_time",                       null: false
    t.datetime "end_time",                         null: false
    t.text     "google_event_id"
    t.boolean  "admin_only",       default: false, null: false
    t.boolean  "ta",               default: false, null: false
    t.boolean  "gl",               default: false, null: false
    t.integer  "calendar_id"
    t.integer  "guest_lecture_id"
    t.integer  "user_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "events", ["calendar_id"], name: "index_events_on_calendar_id", using: :btree
  add_index "events", ["gl"], name: "index_events_on_gl", using: :btree
  add_index "events", ["guest_lecture_id"], name: "index_events_on_guest_lecture_id", using: :btree
  add_index "events", ["ta"], name: "index_events_on_ta", using: :btree

  create_table "events_users", id: false, force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "user_id",  null: false
  end

  add_index "events_users", ["event_id"], name: "index_events_users_on_event_id", using: :btree
  add_index "events_users", ["user_id"], name: "index_events_users_on_user_id", using: :btree

  create_table "guest_lectures", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.text     "title",       null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "guest_lectures", ["user_id"], name: "index_guest_lectures_on_user_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.text     "note",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "oauths", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.text     "provider",     null: false
    t.text     "provider_uid", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "oauths", ["user_id"], name: "index_oauths_on_user_id", using: :btree

  create_table "special_conditions", force: :cascade do |t|
    t.integer  "new_ta_requirement", null: false
    t.datetime "date",               null: false
    t.integer  "calendar_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "special_conditions", ["calendar_id"], name: "index_special_conditions_on_calendar_id", using: :btree
  add_index "special_conditions", ["date"], name: "index_special_conditions_on_date", using: :btree

  create_table "users", force: :cascade do |t|
    t.text     "password_digest"
    t.text     "name",            null: false
    t.citext   "email",           null: false
    t.citext   "github"
    t.string   "type",            null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
