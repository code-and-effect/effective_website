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

ActiveRecord::Schema.define(version: 2019_04_20_034055) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", id: :serial, force: :cascade do |t|
    t.string "addressable_type"
    t.integer "addressable_id"
    t.string "category", limit: 64
    t.string "full_name"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state_code"
    t.string "country_code"
    t.string "postal_code"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.index ["addressable_id"], name: "index_addresses_on_addressable_id"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "cart_items", id: :serial, force: :cascade do |t|
    t.integer "cart_id"
    t.string "purchasable_type"
    t.integer "purchasable_id"
    t.string "unique"
    t.integer "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["purchasable_id"], name: "index_cart_items_on_purchasable_id"
    t.index ["purchasable_type", "purchasable_id"], name: "index_cart_items_on_purchasable_type_and_purchasable_id"
  end

  create_table "carts", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "cart_items_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.boolean "archived", default: false
    t.integer "mates_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "stripe_customer_id"
    t.string "active_card"
    t.string "status"
    t.integer "subscriptions_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "logs", id: :serial, force: :cascade do |t|
    t.integer "parent_id"
    t.integer "user_id"
    t.string "changes_to_type"
    t.integer "changes_to_id"
    t.string "associated_type"
    t.integer "associated_id"
    t.string "associated_to_s"
    t.integer "logs_count"
    t.text "message"
    t.text "details"
    t.string "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["associated_id"], name: "index_logs_on_associated_id"
    t.index ["associated_to_s"], name: "index_logs_on_associated_to_s"
    t.index ["associated_type", "associated_id"], name: "index_logs_on_associated_type_and_associated_id"
    t.index ["parent_id"], name: "index_logs_on_parent_id"
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "mates", force: :cascade do |t|
    t.integer "client_id"
    t.integer "user_id"
    t.integer "roles_mask"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menu_items", id: :serial, force: :cascade do |t|
    t.integer "menu_id"
    t.integer "menuable_id"
    t.string "menuable_type"
    t.string "title"
    t.string "url"
    t.string "special"
    t.string "classes"
    t.boolean "new_window", default: false
    t.integer "roles_mask"
    t.integer "lft"
    t.integer "rgt"
    t.index ["lft"], name: "index_menu_items_on_lft"
  end

  create_table "menus", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_items", id: :serial, force: :cascade do |t|
    t.integer "order_id"
    t.string "purchasable_type"
    t.integer "purchasable_id"
    t.string "name"
    t.integer "quantity"
    t.integer "price", default: 0
    t.boolean "tax_exempt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["purchasable_id"], name: "index_order_items_on_purchasable_id"
    t.index ["purchasable_type", "purchasable_id"], name: "index_order_items_on_purchasable_type_and_purchasable_id"
  end

  create_table "orders", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "state"
    t.datetime "purchased_at"
    t.text "note"
    t.text "note_to_buyer"
    t.text "note_internal"
    t.string "billing_name"
    t.text "payment"
    t.string "payment_provider"
    t.string "payment_card"
    t.decimal "tax_rate", precision: 6, scale: 3
    t.integer "subtotal"
    t.integer "tax"
    t.integer "total"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "pages", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "meta_description"
    t.boolean "draft", default: false
    t.string "layout", default: "application"
    t.string "template"
    t.string "slug"
    t.integer "roles_mask", default: 0
    t.datetime "updated_at"
    t.datetime "created_at"
    t.index ["slug"], name: "index_pages_on_slug", unique: true
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.integer "purchased_order_id"
    t.string "name"
    t.integer "price"
    t.boolean "tax_exempt", default: false
    t.string "qb_item_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", id: :serial, force: :cascade do |t|
    t.string "regionable_type"
    t.integer "regionable_id"
    t.string "title"
    t.text "content"
    t.text "snippets"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.index ["regionable_id"], name: "index_regions_on_regionable_id"
    t.index ["regionable_type", "regionable_id"], name: "index_regions_on_regionable_type_and_regionable_id"
  end

  create_table "subscriptions", id: :serial, force: :cascade do |t|
    t.integer "customer_id"
    t.integer "subscribable_id"
    t.string "subscribable_type"
    t.string "stripe_plan_id"
    t.string "stripe_subscription_id"
    t.string "name"
    t.string "description"
    t.string "interval"
    t.integer "quantity"
    t.string "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["customer_id"], name: "index_subscriptions_on_customer_id"
    t.index ["subscribable_id"], name: "index_subscriptions_on_subscribable_id"
    t.index ["subscribable_type", "subscribable_id"], name: "index_subscriptions_on_subscribable_type_and_subscribable_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "email", default: "", null: false
    t.string "name"
    t.integer "roles_mask"
    t.boolean "avatar_attached"
    t.boolean "archived", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.integer "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
