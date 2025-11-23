# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_11_23_172943) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "turf_id", null: false
    t.datetime "booking_date"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "total_price"
    t.integer "status", default: 0
    t.integer "total_hours"
    t.string "payment_status", default: "unpaid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["turf_id"], name: "index_bookings_on_turf_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "turves", force: :cascade do |t|
    t.string "name"
    t.string "pin_code"
    t.string "address"
    t.integer "price_per_hour"
    t.boolean "availability", default: true
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.index ["user_id"], name: "index_turves_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password", null: false
    t.string "name", null: false
    t.string "role", default: "user", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "bookings", "turves"
  add_foreign_key "bookings", "users"
  add_foreign_key "turves", "users"
end
