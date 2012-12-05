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

ActiveRecord::Schema.define(:version => 20121205112450) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "image"
  end

  create_table "developers", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "image"
  end

  create_table "games", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "image"
  end

  create_table "games_genres", :id => false, :force => true do |t|
    t.integer "game_id"
    t.integer "genre_id"
  end

  create_table "games_media", :id => false, :force => true do |t|
    t.integer "game_id"
    t.integer "medium_id"
  end

  create_table "games_modes", :id => false, :force => true do |t|
    t.integer "game_id"
    t.integer "mode_id"
  end

  create_table "games_platforms", :id => false, :force => true do |t|
    t.integer "game_id"
    t.integer "platform_id"
  end

  create_table "games_tags", :id => false, :force => true do |t|
    t.integer "game_id"
    t.integer "tag_id"
  end

  create_table "genres", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "media", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mixed_field_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mixed_fields", :force => true do |t|
    t.integer  "game_id"
    t.integer  "developer_id"
    t.integer  "company_id"
    t.string   "not_found"
    t.string   "additional_info"
    t.integer  "mixed_field_type_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "series_game_id"
  end

  add_index "mixed_fields", ["company_id"], :name => "index_mixed_fields_on_company_id"
  add_index "mixed_fields", ["developer_id"], :name => "index_mixed_fields_on_developer_id"
  add_index "mixed_fields", ["game_id"], :name => "index_mixed_fields_on_game_id"
  add_index "mixed_fields", ["mixed_field_type_id"], :name => "index_mixed_fields_on_mixed_field_type_id"
  add_index "mixed_fields", ["series_game_id"], :name => "index_mixed_fields_on_series_game_id"

  create_table "modes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "platforms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "release_dates", :force => true do |t|
    t.integer  "year"
    t.integer  "month"
    t.integer  "day"
    t.string   "additional_info"
    t.integer  "game_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "release_dates", ["game_id"], :name => "index_release_dates_on_game_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "firstname"
    t.string   "lastname"
    t.boolean  "admin"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
