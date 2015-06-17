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

ActiveRecord::Schema.define(version: 20150617135932) do

  create_table "device_profiles", force: :cascade do |t|
    t.string   "data_transformer"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "name"
    t.string   "profile_name"
    t.string   "device_type"
    t.string   "hw_version"
    t.string   "sw_version"
    t.string   "info"
  end

  create_table "devices", force: :cascade do |t|
    t.string   "device_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "user_id"
    t.string   "device_profile_id"
  end

  create_table "sensor_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sensors", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "device_profile_id"
    t.string   "sensor_type_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
