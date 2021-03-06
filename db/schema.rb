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

ActiveRecord::Schema.define(version: 20161117003159) do

  create_table "activities", force: true do |t|
    t.integer  "user_id"
    t.integer  "family_id"
    t.integer  "type_id"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "media_id"
    t.datetime "posted_at"
  end

  create_table "completions", force: true do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.string   "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "start_time"
    t.string   "description"
    t.integer  "user_id"
    t.string   "event_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "families", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "price"
    t.string   "thumbnail"
    t.integer  "family_id"
    t.string   "used_by"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "meals", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "menu_day"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "family_id"
  end

  create_table "purchases", force: true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registrations", force: true do |t|
    t.integer  "family_id"
    t.integer  "course_id"
    t.string   "email"
    t.string   "card_token"
    t.string   "customer_id"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "social_media", force: true do |t|
    t.integer  "feed_type"
    t.integer  "user_id"
    t.string   "full_name"
    t.string   "username"
    t.string   "picture"
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "secret"
    t.string   "uid"
    t.datetime "posted_at"
    t.string   "last_id"
  end

  create_table "social_medium_stats", force: true do |t|
    t.integer  "user_id"
    t.string   "instagram"
    t.string   "facebook"
    t.string   "twitter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.integer  "user_id"
    t.integer  "family_id"
    t.string   "title"
    t.string   "description"
    t.datetime "next_date"
    t.boolean  "daily"
    t.boolean  "weekly"
    t.boolean  "monthly"
    t.boolean  "sunday"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.integer  "period"
    t.integer  "how_often"
    t.datetime "custom_start"
    t.integer  "points"
    t.boolean  "as_needed"
    t.string   "assigned"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "required"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.integer  "family_id"
    t.integer  "credits"
    t.string   "email"
    t.boolean  "parent"
    t.string   "pin"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "timezone"
    t.integer  "allowance"
    t.datetime "last_allowance"
    t.boolean  "enabled"
    t.string   "status"
    t.string   "uid"
    t.integer  "notifications"
    t.datetime "dob"
    t.string   "token"
  end

end
