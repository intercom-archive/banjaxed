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

ActiveRecord::Schema.define(version: 20140731015958) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "incident_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "incidents", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "severity"
    t.string   "status",      default: "open"
    t.datetime "started_at"
    t.datetime "detected_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "incidents", ["user_id"], name: "index_incidents_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.integer  "github_id"
    t.string   "github_username"
    t.string   "name"
    t.string   "gravatar_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["github_id"], name: "index_users_on_github_id", unique: true, using: :btree

end
