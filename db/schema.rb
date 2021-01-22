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

ActiveRecord::Schema.define(version: 2021_01_19_161533) do

  create_table "accounts", charset: "utf8mb4", force: :cascade do |t|
    t.string "email"
    t.string "full_name"
    t.date "date_of_birth"
    t.integer "gender", default: 0
    t.string "card_id"
    t.string "address"
    t.integer "role", default: 0, null: false
    t.integer "status", default: 1
    t.string "password_digest"
    t.string "remember_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phone_number"
  end

  create_table "active_storage_attachments", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "licenses", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "major_id", null: false
    t.bigint "account_id", null: false
    t.string "level"
    t.string "workspace"
    t.date "date_of_issue"
    t.string "place_of_issue"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_licenses_on_account_id"
    t.index ["major_id"], name: "index_licenses_on_major_id"
  end

  create_table "majors", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_details", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "service_id", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.decimal "into_money", precision: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["service_id"], name: "index_order_details_on_service_id"
  end

  create_table "orders", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.integer "staff_id"
    t.text "description"
    t.integer "status"
    t.decimal "total_price", precision: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_orders_on_account_id"
  end

  create_table "reviews", charset: "utf8mb4", force: :cascade do |t|
    t.integer "reviewer_id"
    t.text "content"
    t.integer "rate"
    t.string "reviewable_type", null: false
    t.bigint "reviewable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reviewable_type", "reviewable_id"], name: "index_reviews_on_reviewable"
  end

  create_table "services", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "major_id", null: false
    t.string "name"
    t.string "image"
    t.decimal "price", precision: 10
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["major_id"], name: "index_services_on_major_id"
  end

  create_table "work_histories", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "order_detail_id", null: false
    t.text "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_detail_id"], name: "index_work_histories_on_order_detail_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "licenses", "accounts"
  add_foreign_key "licenses", "majors"
  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "services"
  add_foreign_key "orders", "accounts"
  add_foreign_key "services", "majors"
  add_foreign_key "work_histories", "order_details"
end
