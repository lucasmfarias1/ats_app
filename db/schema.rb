# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_01_25_204832) do

  create_table "applicants", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.string "summary"
    t.string "photo_url"
    t.integer "rating"
    t.string "phone"
    t.string "email"
    t.string "website"
    t.string "location"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_applicants_on_user_id"
  end

  create_table "applicants_tags", id: false, force: :cascade do |t|
    t.integer "applicant_id", null: false
    t.integer "tag_id", null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.text "json_data"
    t.string "url"
    t.string "filename"
    t.integer "applicant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["applicant_id"], name: "index_attachments_on_applicant_id"
  end

  create_table "beat_spells", force: :cascade do |t|
    t.integer "spell_id", null: false
    t.integer "player_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_beat_spells_on_player_id"
    t.index ["spell_id"], name: "index_beat_spells_on_spell_id"
  end

  create_table "notes", force: :cascade do |t|
    t.text "content"
    t.integer "applicant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["applicant_id"], name: "index_notes_on_applicant_id"
  end

  create_table "players", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "spells", force: :cascade do |t|
    t.string "champion"
    t.string "name"
    t.string "cooldown"
    t.string "cost"
    t.string "key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "tier", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "applicants", "users"
  add_foreign_key "attachments", "applicants"
  add_foreign_key "beat_spells", "players"
  add_foreign_key "beat_spells", "spells"
  add_foreign_key "notes", "applicants"
  add_foreign_key "tags", "users"
end
