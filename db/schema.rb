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

ActiveRecord::Schema.define(version: 20161105200336) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.float    "lat"
    t.float    "lon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "amenities", force: :cascade do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "camp_infos", force: :cascade do |t|
    t.string   "camp_type"
    t.string   "description"
    t.string   "url"
    t.integer  "camp_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "camp_infos_to_amenities", force: :cascade do |t|
    t.integer "camp_id"
    t.integer "amenity_id"
  end

  create_table "camp_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "camps", force: :cascade do |t|
    t.string   "name"
    t.integer  "address_id"
    t.integer  "contact_id"
    t.string   "web_url"
    t.boolean  "pccca_member"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "phone_number"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "f_name"
    t.string   "l_name"
    t.string   "title"
    t.integer  "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.integer  "camp_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "image_type"
    t.string   "image_url_file_name"
    t.string   "image_url_content_type"
    t.integer  "image_url_file_size"
    t.datetime "image_url_updated_at"
  end

  create_table "site_setups", force: :cascade do |t|
    t.integer  "hotel"
    t.integer  "group_local_bath"
    t.integer  "group_sep_bath"
    t.integer  "rustic"
    t.integer  "rv"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "camp_id"
  end

end
