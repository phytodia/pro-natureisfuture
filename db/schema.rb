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

ActiveRecord::Schema[7.0].define(version: 2024_02_22_074306) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "carte_soins", force: :cascade do |t|
    t.bigint "carte_id", null: false
    t.bigint "soin_id"
    t.bigint "custom_soin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "estimated_time"
    t.integer "price_ttc_cents", default: 0, null: false
    t.index ["carte_id"], name: "index_carte_soins_on_carte_id"
    t.index ["custom_soin_id"], name: "index_carte_soins_on_custom_soin_id"
    t.index ["soin_id"], name: "index_carte_soins_on_soin_id"
  end

  create_table "cartes", force: :cascade do |t|
    t.bigint "institut_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institut_id"], name: "index_cartes_on_institut_id"
  end

  create_table "chapters", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.string "titre"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rank"
    t.index ["course_id"], name: "index_chapters_on_course_id"
  end

  create_table "commercials", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "lastname"
    t.string "firstname"
    t.string "tel"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_commercials_on_email", unique: true
    t.index ["reset_password_token"], name: "index_commercials_on_reset_password_token", unique: true
  end

  create_table "courses", force: :cascade do |t|
    t.string "titre"
    t.text "introduction"
    t.integer "duree"
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "custom_soins", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.text "description"
    t.string "estimated_time"
    t.string "category"
    t.integer "price_ttc_cents", default: 0, null: false
    t.index ["customer_id"], name: "index_custom_soins_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "lastname"
    t.string "firstname"
    t.string "institut"
    t.string "cp"
    t.string "country"
    t.string "town"
    t.string "tel"
    t.integer "commercial_id"
    t.integer "prospect_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "instituts", force: :cascade do |t|
    t.string "name"
    t.string "tel"
    t.string "address"
    t.string "cp"
    t.string "city"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.bigint "customer_id"
    t.json "horaires", default: {}
    t.string "category"
    t.string "fb"
    t.string "ig"
    t.string "tik_tok"
    t.string "rdv"
    t.string "mess_promo"
    t.text "description"
    t.string "region"
    t.string "slug"
    t.index ["customer_id"], name: "index_instituts_on_customer_id"
    t.index ["slug"], name: "index_instituts_on_slug", unique: true
  end

  create_table "order_products", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "product_id", null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount_ht_cents", default: 0, null: false
    t.index ["order_id"], name: "index_order_products_on_order_id"
    t.index ["product_id"], name: "index_order_products_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.string "prestashop_reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount_ht_cents", default: 0, null: false
    t.integer "amount_ttc_cents", default: 0, null: false
    t.integer "tva_cents", default: 0, null: false
    t.integer "reduction_ht_cents", default: 0, null: false
    t.datetime "custom_date"
    t.string "state"
    t.string "payment_mode"
    t.integer "institut_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "poly_messages", force: :cascade do |t|
    t.text "content"
    t.string "message_type", null: false
    t.bigint "message_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_type", "message_id"], name: "index_poly_messages_on_message"
  end

  create_table "product_custom_soin_items", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "custom_soin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ml"
    t.index ["custom_soin_id"], name: "index_product_custom_soin_items_on_custom_soin_id"
    t.index ["product_id"], name: "index_product_custom_soin_items_on_product_id"
  end

  create_table "product_soin_items", force: :cascade do |t|
    t.integer "ml"
    t.bigint "product_id", null: false
    t.bigint "soin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_soin_items_on_product_id"
    t.index ["soin_id"], name: "index_product_soin_items_on_soin_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "actions_product", array: true
    t.string "gamme"
    t.string "labels", array: true
    t.string "types_peau", array: true
    t.string "texture"
    t.string "utilisation"
    t.string "yuka_appreciation"
    t.text "product_plus"
    t.text "product_conseil"
    t.text "product_gestes"
    t.string "ingredients", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "contenance_revente"
    t.integer "contenance_cabine"
    t.string "product_actifs", array: true
    t.string "ean"
    t.integer "price_ht_cents", default: 0, null: false
    t.text "preoccupations", default: [], array: true
    t.text "types_produit", default: [], array: true
    t.string "slug"
    t.text "products_complementaires", default: [], array: true
    t.index ["slug"], name: "index_products_on_slug", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "role"
    t.string "tel"
    t.string "address"
    t.string "city"
    t.string "cp"
    t.string "country"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "team_member_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "prospects", force: :cascade do |t|
    t.string "lastname"
    t.string "firstname"
    t.string "email"
    t.string "source"
    t.string "institut"
    t.string "cp"
    t.string "country"
    t.string "town"
    t.string "tel"
    t.datetime "date_prospect"
    t.string "statut", default: "nouveau"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "commercial_id"
  end

  create_table "soins", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.text "description"
    t.string "estimated_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_ttc_cents", default: 0, null: false
    t.string "slug"
    t.index ["slug"], name: "index_soins_on_slug", unique: true
  end

  create_table "team_members", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "role"
    t.string "tel"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_team_members_on_user_id"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "carte_soins", "cartes"
  add_foreign_key "carte_soins", "custom_soins"
  add_foreign_key "carte_soins", "soins"
  add_foreign_key "cartes", "instituts"
  add_foreign_key "chapters", "courses"
  add_foreign_key "custom_soins", "customers"
  add_foreign_key "instituts", "customers"
  add_foreign_key "order_products", "orders"
  add_foreign_key "order_products", "products"
  add_foreign_key "orders", "customers"
  add_foreign_key "product_custom_soin_items", "custom_soins"
  add_foreign_key "product_custom_soin_items", "products"
  add_foreign_key "product_soin_items", "products"
  add_foreign_key "product_soin_items", "soins"
  add_foreign_key "profiles", "team_members"
  add_foreign_key "profiles", "users"
  add_foreign_key "team_members", "users"
end
