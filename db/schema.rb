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

ActiveRecord::Schema.define(version: 20170905041931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "pgcrypto"

  create_table "beacons", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "lot_id"
    t.string "manufacturer_uuid"
    t.integer "major"
    t.integer "minor"
    t.jsonb "coordinates"
    t.datetime "last_activity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lot_id"], name: "index_beacons_on_lot_id"
  end

  create_table "buildings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.jsonb "address"
    t.string "name"
    t.jsonb "floor_levels"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "little_brother_chips", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_little_brother_chips_on_user_id"
  end

  create_table "locations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "little_brother_chip_id"
    t.uuid "lot_id"
    t.jsonb "coordinates"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["little_brother_chip_id"], name: "index_locations_on_little_brother_chip_id"
    t.index ["lot_id"], name: "index_locations_on_lot_id"
  end

  create_table "lots", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "building_id"
    t.string "lot_type"
    t.string "name"
    t.integer "floor_level"
    t.jsonb "dimensions"
    t.float "rssi_1m_away_from_beacon"
    t.float "average_phone_height"
    t.float "path_loss"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["building_id"], name: "index_lots_on_building_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
