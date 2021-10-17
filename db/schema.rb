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

ActiveRecord::Schema.define(version: 2021_10_25_230107) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.bigint "table_id", null: false
    t.integer "quantity_available", null: false
    t.date "date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["table_id", "date"], name: "index_availabilities_on_table_id_and_date", unique: true
    t.index ["table_id"], name: "index_availabilities_on_table_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "table_id", null: false
    t.string "name"
    t.string "email", null: false
    t.integer "guests", null: false
    t.date "date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["table_id"], name: "index_reservations_on_table_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tables", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.string "name"
    t.integer "quantity", null: false
    t.integer "min_guests", null: false
    t.integer "max_guests", null: false
    t.time "available_from", null: false
    t.time "available_to", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["restaurant_id", "min_guests"], name: "index_tables_on_restaurant_id_and_min_guests"
    t.index ["restaurant_id"], name: "index_tables_on_restaurant_id"
  end

  add_foreign_key "availabilities", "tables"
  add_foreign_key "reservations", "tables"
  add_foreign_key "tables", "restaurants"
end
