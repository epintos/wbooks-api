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

ActiveRecord::Schema.define(version: 2020_01_10_081756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_suggestions", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "editorial"
    t.float "price"
    t.string "author"
    t.string "title"
    t.string "link"
    t.string "publisher"
    t.integer "year"
    t.index ["user_id"], name: "index_book_suggestions_on_user_id"
  end

  create_table "books", id: :serial, force: :cascade do |t|
    t.string "author"
    t.string "title"
    t.string "image"
    t.string "publisher"
    t.string "year"
    t.string "genre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.string "content"
    t.integer "user_id"
    t.integer "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["book_id"], name: "index_comments_on_book_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.integer "reason", null: false
    t.string "action_type"
    t.integer "action_id"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "from_id"
    t.integer "to_id"
    t.string "body"
    t.index ["action_type", "action_id"], name: "index_notifications_on_action_type_and_action_id"
    t.index ["from_id"], name: "index_notifications_on_from_id"
    t.index ["to_id"], name: "index_notifications_on_to_id"
  end

  create_table "rents", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "book_id"
    t.date "from"
    t.date "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "returned_at"
    t.index ["book_id"], name: "index_rents_on_book_id"
    t.index ["user_id"], name: "index_rents_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "verification_code", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "locale"
    t.integer "unread_notifications_count", default: 0, null: false
    t.integer "rents_counter", default: 0, null: false
    t.integer "comments_counter", default: 0, null: false
    t.string "image"
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.json "tokens"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "wishes", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_wishes_on_book_id"
    t.index ["user_id"], name: "index_wishes_on_user_id"
  end

  add_foreign_key "book_suggestions", "users"
  add_foreign_key "comments", "books"
  add_foreign_key "comments", "users"
  add_foreign_key "notifications", "users", column: "from_id"
  add_foreign_key "notifications", "users", column: "to_id"
  add_foreign_key "rents", "books"
  add_foreign_key "rents", "users"
  add_foreign_key "wishes", "books"
  add_foreign_key "wishes", "users"
end
