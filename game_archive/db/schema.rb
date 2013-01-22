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

ActiveRecord::Schema.define(:version => 20130113152519) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image"
    t.string   "official_name"
    t.integer  "popularity"
    t.string   "version_id"
    t.integer  "version_number"
    t.datetime "version_updated_at"
    t.integer  "version_author_id"
  end

  add_index "companies", ["version_id"], :name => "index_companies_on_version_id"

  create_table "company_defuncts", :force => true do |t|
    t.integer  "company_id"
    t.integer  "day"
    t.integer  "month"
    t.integer  "year"
    t.string   "additional_info"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "company_defuncts", ["company_id"], :name => "index_company_defuncts_on_company_id"

  create_table "company_foundeds", :force => true do |t|
    t.integer  "company_id"
    t.integer  "day"
    t.integer  "month"
    t.integer  "year"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "company_foundeds", ["company_id"], :name => "index_company_foundeds_on_company_id"

  create_table "developers", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image"
    t.integer  "popularity"
    t.string   "version_id"
    t.integer  "version_number"
    t.datetime "version_updated_at"
    t.integer  "version_author_id"
  end

  add_index "developers", ["version_id"], :name => "index_developers_on_version_id"

  create_table "fields", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "game_id"
    t.integer  "company_id"
    t.integer  "developer_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "fields", ["company_id"], :name => "index_fields_on_company_id"
  add_index "fields", ["developer_id"], :name => "index_fields_on_developer_id"
  add_index "fields", ["game_id"], :name => "index_fields_on_game_id"

  create_table "games", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image"
    t.integer  "popularity"
    t.string   "version_id"
    t.integer  "version_number"
    t.datetime "version_updated_at"
    t.integer  "version_author_id"
  end

  add_index "games", ["version_id"], :name => "index_games_on_version_id"

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

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "additional_info"
    t.integer  "company_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "locations", ["company_id"], :name => "index_locations_on_company_id"

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
  add_index "mixed_fields", ["series_game_id"], :name => "mf_series_game_index"

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

  create_table "reportblockcontents", :force => true do |t|
    t.integer  "content_type"
    t.integer  "content_id"
    t.integer  "status"
    t.string   "reason"
    t.string   "email"
    t.integer  "admin_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "screenshots", :force => true do |t|
    t.string   "image"
    t.integer  "game_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "screenshots", ["game_id"], :name => "index_screenshots_on_game_id"

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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "blocked"
    t.string   "note"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "videos", :force => true do |t|
    t.text     "embedcode"
    t.integer  "game_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "videos", ["game_id"], :name => "index_videos_on_game_id"

end
