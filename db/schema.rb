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

ActiveRecord::Schema[7.0].define(version: 2023_12_14_124510) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "instituts", force: :cascade do |t|
    t.string "name"
    t.string "tel"
    t.string "address"
    t.string "cp"
    t.string "city"
    t.string "country"
    t.bigint "profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["profile_id"], name: "index_instituts_on_profile_id"
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

  add_foreign_key "instituts", "profiles"
  add_foreign_key "profiles", "team_members"
  add_foreign_key "profiles", "users"
  add_foreign_key "team_members", "users"
end
