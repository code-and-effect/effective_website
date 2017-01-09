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

ActiveRecord::Schema.define(version: 20161221200928) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.string   "category",         limit: 64
    t.string   "full_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state_code"
    t.string   "country_code"
    t.string   "postal_code"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.index ["addressable_id"], name: "index_addresses_on_addressable_id", using: :btree
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id", using: :btree
  end

  create_table "assets", force: :cascade do |t|
    t.string   "title"
    t.text     "extra"
    t.integer  "user_id"
    t.string   "content_type"
    t.text     "upload_file"
    t.string   "data"
    t.boolean  "processed",     default: false
    t.string   "aws_acl",       default: "public-read"
    t.integer  "data_size"
    t.integer  "height"
    t.integer  "width"
    t.text     "versions_info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["content_type"], name: "index_assets_on_content_type", using: :btree
    t.index ["user_id"], name: "index_assets_on_user_id", using: :btree
  end

  create_table "attachments", force: :cascade do |t|
    t.integer "asset_id"
    t.string  "attachable_type"
    t.integer "attachable_id"
    t.integer "position"
    t.string  "box"
    t.index ["asset_id"], name: "index_attachments_on_asset_id", using: :btree
    t.index ["attachable_id"], name: "index_attachments_on_attachable_id", using: :btree
    t.index ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable_type_and_attachable_id", using: :btree
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer  "cart_id"
    t.string   "purchasable_type"
    t.integer  "purchasable_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id", using: :btree
    t.index ["purchasable_id"], name: "index_cart_items_on_purchasable_id", using: :btree
    t.index ["purchasable_type", "purchasable_id"], name: "index_cart_items_on_purchasable_type_and_purchasable_id", using: :btree
  end

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_carts_on_user_id", using: :btree
  end

  create_table "customers", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "stripe_customer_id"
    t.string   "stripe_active_card"
    t.string   "stripe_connect_access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_customers_on_user_id", using: :btree
  end

  create_table "logs", force: :cascade do |t|
    t.integer  "parent_id"
    t.integer  "user_id"
    t.string   "associated_type"
    t.integer  "associated_id"
    t.integer  "logs_count"
    t.string   "message"
    t.text     "details"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["associated_id"], name: "index_logs_on_associated_id", using: :btree
    t.index ["associated_type", "associated_id"], name: "index_logs_on_associated_type_and_associated_id", using: :btree
    t.index ["parent_id"], name: "index_logs_on_parent_id", using: :btree
    t.index ["user_id"], name: "index_logs_on_user_id", using: :btree
  end

  create_table "menu_items", force: :cascade do |t|
    t.integer "menu_id"
    t.integer "menuable_id"
    t.string  "menuable_type"
    t.string  "title"
    t.string  "url"
    t.string  "special"
    t.string  "classes"
    t.boolean "new_window",    default: false
    t.integer "roles_mask"
    t.integer "lft"
    t.integer "rgt"
    t.index ["lft"], name: "index_menu_items_on_lft", using: :btree
  end

  create_table "menus", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "seller_id"
    t.string   "purchasable_type"
    t.integer  "purchasable_id"
    t.string   "title"
    t.integer  "quantity"
    t.integer  "price",            default: 0
    t.boolean  "tax_exempt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
    t.index ["purchasable_id"], name: "index_order_items_on_purchasable_id", using: :btree
    t.index ["purchasable_type", "purchasable_id"], name: "index_order_items_on_purchasable_type_and_purchasable_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "purchase_state"
    t.datetime "purchased_at"
    t.text     "note"
    t.text     "note_to_buyer"
    t.text     "note_internal"
    t.text     "payment"
    t.string   "payment_provider"
    t.string   "payment_card"
    t.decimal  "tax_rate",         precision: 6, scale: 3
    t.integer  "subtotal"
    t.integer  "tax"
    t.integer  "total"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.string   "meta_description"
    t.boolean  "draft",            default: false
    t.string   "layout",           default: "application"
    t.string   "template"
    t.string   "slug"
    t.integer  "roles_mask",       default: 0
    t.datetime "updated_at"
    t.datetime "created_at"
    t.index ["slug"], name: "index_pages_on_slug", unique: true, using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "category"
    t.boolean  "draft",        default: false
    t.text     "tags"
    t.integer  "roles_mask",   default: 0
    t.datetime "published_at"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.integer  "price",      default: 0
    t.boolean  "tax_exempt", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", force: :cascade do |t|
    t.string   "regionable_type"
    t.integer  "regionable_id"
    t.string   "title"
    t.text     "content"
    t.text     "snippets"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.index ["regionable_id"], name: "index_regions_on_regionable_id", using: :btree
    t.index ["regionable_type", "regionable_id"], name: "index_regions_on_regionable_type_and_regionable_id", using: :btree
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "stripe_plan_id"
    t.string   "stripe_subscription_id"
    t.string   "stripe_coupon_id"
    t.string   "title"
    t.integer  "price",                  default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["customer_id"], name: "index_subscriptions_on_customer_id", using: :btree
    t.index ["stripe_subscription_id"], name: "index_subscriptions_on_stripe_subscription_id", using: :btree
  end

  create_table "trash", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "trashed_type"
    t.integer  "trashed_id"
    t.string   "trashed_to_s"
    t.string   "trashed_extra"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["trashed_extra"], name: "index_trash_on_trashed_extra", using: :btree
    t.index ["trashed_id"], name: "index_trash_on_trashed_id", using: :btree
    t.index ["trashed_type", "trashed_id"], name: "index_trash_on_trashed_type_and_trashed_id", using: :btree
    t.index ["user_id"], name: "index_trash_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "email",                  default: "", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "roles_mask"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.string   "invited_by_type"
    t.integer  "invited_by_id"
    t.integer  "invitations_count",      default: 0
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
