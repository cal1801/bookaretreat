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

ActiveRecord::Schema.define(version: 20170829165948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "fuzzystrmatch"
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
    t.integer  "camp_id"
  end

  add_index "addresses", ["camp_id"], name: "index_addresses_on_camp_id", using: :btree

  create_table "amenities", force: :cascade do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "amenities_camps", force: :cascade do |t|
    t.integer "camp_id"
    t.integer "amenity_id"
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
    t.integer  "contact_id"
    t.string   "web_url"
    t.boolean  "pccca_member"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "phone_number"
    t.string   "camp_desc"
    t.string   "camp_url"
    t.string   "staff_desc"
    t.string   "staff_url"
    t.string   "slug"
    t.boolean  "bar",          default: true
    t.boolean  "str",          default: true
    t.boolean  "bsy",          default: true
  end

  add_index "camps", ["slug"], name: "index_camps_on_slug", unique: true, using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "f_name"
    t.string   "l_name"
    t.string   "title"
    t.integer  "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
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

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "addresses", "camps"
end
