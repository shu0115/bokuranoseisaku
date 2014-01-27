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

ActiveRecord::Schema.define(version: 20140127052246) do

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.string   "location"
    t.string   "gender"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id"

  create_table "reputations", force: true do |t|
    t.string   "type"
    t.integer  "user_id"
    t.integer  "tweet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reputations", ["tweet_id"], name: "index_reputations_on_tweet_id"
  add_index "reputations", ["user_id"], name: "index_reputations_on_user_id"

  create_table "tweets", force: true do |t|
    t.integer  "tweet_id",       limit: 8
    t.string   "twitter_uid"
    t.string   "screen_name"
    t.text     "content"
    t.datetime "tweet_at"
    t.integer  "retweet_count"
    t.integer  "favorite_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "good_count",               default: 0
    t.integer  "bad_count",                default: 0
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.string   "email"
    t.boolean  "admin_flag",          default: false
    t.string   "last_login_provider"
    t.datetime "last_login_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
