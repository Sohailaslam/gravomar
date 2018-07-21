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

ActiveRecord::Schema.define(version: 20180718093141) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "phone_number2"
    t.date "dob"
    t.integer "vat"
    t.text "notes"
    t.boolean "admin", default: false
    t.integer "order_id"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 1
  end

  create_table "jobs", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "material"
    t.date "delivery_date"
    t.integer "quantity"
    t.float "cost"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.text "notes"
    t.integer "cost"
    t.integer "client_id"
    t.date "delivery_date"
    t.float "length"
    t.float "height"
    t.string "frame"
    t.string "passe_partout"
    t.string "accessory"
    t.float "others", default: 0.0
    t.integer "status", default: 1
    t.integer "advance", default: 0
    t.integer "discount", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "seller"
    t.string "client_name"
    t.string "client_phone"
    t.decimal "frame_cost"
    t.decimal "accessory_cost"
    t.decimal "passe_partout_cost"
    t.decimal "tax_cost"
    t.decimal "discount_amount"
  end

  create_table "product_orders", force: :cascade do |t|
    t.integer "product_id"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer "cost"
    t.string "color"
    t.integer "height"
    t.integer "width"
    t.float "price"
    t.text "notes"
    t.string "frame"
    t.string "passe_partout"
    t.string "accessory"
    t.string "seller"
    t.integer "stock"
    t.integer "kind"
    t.string "product_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["product_code"], name: "index_products_on_product_code", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "name"
    t.string "username"
    t.string "phone_number"
    t.string "phone_number2"
    t.date "dob"
    t.integer "vat"
    t.text "notes"
    t.string "identifier"
    t.string "company_name"
    t.string "linkedin_link"
    t.string "githhub_link"
    t.string "website_link"
    t.string "portfolio"
    t.string "other_link1"
    t.string "other_link2"
    t.string "other_link3"
    t.text "experience"
    t.boolean "admin", default: false
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
