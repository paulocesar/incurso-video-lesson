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

ActiveRecord::Schema.define(:version => 20130207000921) do

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.text     "information"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.text     "information"
    t.integer  "discount"
    t.integer  "area_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "courses", ["area_id"], :name => "index_courses_on_area_id"
  add_index "courses", ["user_id"], :name => "index_courses_on_user_id"

  create_table "courses_users", :id => false, :force => true do |t|
    t.integer "course_id"
    t.integer "user_id"
  end

  add_index "courses_users", ["course_id", "user_id"], :name => "index_courses_users_on_course_id_and_user_id"
  add_index "courses_users", ["user_id", "course_id"], :name => "index_courses_users_on_user_id_and_course_id"

  create_table "descriptions", :force => true do |t|
    t.string   "name"
    t.string   "picture"
    t.string   "address"
    t.string   "phone"
    t.text     "information"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "owners_friends", :id => false, :force => true do |t|
    t.integer "owner_id"
    t.integer "friend_id"
  end

  add_index "owners_friends", ["friend_id", "owner_id"], :name => "index_owners_friends_on_friend_id_and_owner_id"
  add_index "owners_friends", ["owner_id", "friend_id"], :name => "index_owners_friends_on_owner_id_and_friend_id"

  create_table "packages", :force => true do |t|
    t.string   "name"
    t.text     "information"
    t.integer  "discount"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "packages", ["user_id"], :name => "index_packages_on_user_id"

  create_table "packages_courses", :id => false, :force => true do |t|
    t.integer "package_id"
    t.integer "course_id"
  end

  add_index "packages_courses", ["course_id", "package_id"], :name => "index_packages_courses_on_course_id_and_package_id"
  add_index "packages_courses", ["package_id", "course_id"], :name => "index_packages_courses_on_package_id_and_course_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "role_id"
    t.integer  "description_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["description_id"], :name => "index_users_on_description_id"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["role_id"], :name => "index_users_on_role_id"

  create_table "users_videos", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "video_id"
  end

  add_index "users_videos", ["user_id", "video_id"], :name => "index_users_videos_on_user_id_and_video_id"
  add_index "users_videos", ["video_id", "user_id"], :name => "index_users_videos_on_video_id_and_user_id"

  create_table "videos", :force => true do |t|
    t.string   "name"
    t.text     "information"
    t.float    "price"
    t.string   "panda_video_id"
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "videos", ["course_id"], :name => "index_videos_on_course_id"
  add_index "videos", ["user_id"], :name => "index_videos_on_user_id"

end
