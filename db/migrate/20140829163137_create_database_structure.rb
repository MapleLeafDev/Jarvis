class CreateDatabaseStructure < ActiveRecord::Migration
  def up
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
      t.integer  "user_id"
      t.integer  "menu_day"
      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
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
    end

    create_table "purchases", force: true do |t|
      t.integer  "user_id"
      t.integer  "item_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
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
      t.boolean  "assigned"
      t.datetime "created_at",   null: false
      t.datetime "updated_at",   null: false
    end

    create_table "users", force: true do |t|
      t.string   "name"
      t.integer  "family_id"
      t.integer  "credits"
      t.string   "email"
      t.boolean  "parent"
      t.integer  "pin"
      t.string   "password_digest"
      t.datetime "created_at",      null: false
      t.datetime "updated_at",      null: false
    end
  end
end
