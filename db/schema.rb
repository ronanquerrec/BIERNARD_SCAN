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

ActiveRecord::Schema.define(version: 2019_11_25_164846) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beer_flavours", force: :cascade do |t|
    t.bigint "flavour_id"
    t.bigint "beer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beer_id"], name: "index_beer_flavours_on_beer_id"
    t.index ["flavour_id"], name: "index_beer_flavours_on_flavour_id"
  end

  create_table "beers", force: :cascade do |t|
    t.string "name"
    t.string "brewery"
    t.string "style"
    t.string "country"
    t.float "alcohol_percentage"
    t.string "colour"
    t.string "description"
    t.integer "sweetness"
    t.integer "bitterness"
    t.integer "fizzing"
    t.integer "strength"
    t.integer "sourness"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favourites", force: :cascade do |t|
    t.bigint "beer_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beer_id"], name: "index_favourites_on_beer_id"
    t.index ["user_id"], name: "index_favourites_on_user_id"
  end

  create_table "flavours", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "beer_flavours", "beers"
  add_foreign_key "beer_flavours", "flavours"
  add_foreign_key "favourites", "beers"
  add_foreign_key "favourites", "users"
end
