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

ActiveRecord::Schema.define(version: 20150217123025) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lines", force: true do |t|
    t.integer "user_id"
    t.integer "video_id"
    t.integer "priority"
  end

  create_table "proposals", force: true do |t|
    t.string   "date"
    t.string   "recruiting_firm"
    t.string   "phone"
    t.string   "email"
    t.string   "producer"
    t.string   "new_firm"
    t.integer  "current_age"
    t.integer  "retirement_age"
    t.integer  "current_production"
    t.integer  "bonus"
    t.float    "production_growth"
    t.float    "current_payout"
    t.float    "new_payout"
    t.boolean  "final"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "video_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

  create_table "videos", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "small_cover_url"
    t.string   "large_cover_url"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
