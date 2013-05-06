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

ActiveRecord::Schema.define(:version => 20130506165001) do

  create_table "completions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "completed"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "start_time"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "description"
    t.integer  "user_id"
    t.string   "event_type"
  end

  create_table "families", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "family_members", :force => true do |t|
    t.integer  "user_id"
    t.integer  "family_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "admin"
  end

  create_table "ingredients", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.integer  "quantity"
    t.integer  "meal_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "price"
    t.string   "thumbnail"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "family_id"
    t.string   "used_by"
  end

  create_table "meals", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "description"
    t.integer  "user_id"
    t.integer  "menu_day"
  end

  create_table "purchases", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "item_id"
  end

  create_table "tasks", :force => true do |t|
    t.integer  "user_id"
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
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.boolean  "as_needed"
    t.boolean  "assigned"
    t.integer  "family_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.integer  "theme_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "credits"
    t.string   "email"
    t.integer  "user_type"
    t.integer  "pin"
    t.string   "password_digest"
    t.string   "time_zone"
  end

end
