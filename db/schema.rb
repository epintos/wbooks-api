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

ActiveRecord::Schema.define(version: 20170622183919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_suggestions", force: :cascade do |t|
    t.integer "user_id"
    t.string  "editorial"
    t.float   "price"
    t.string  "author"
    t.string  "title"
    t.string  "link"
    t.string  "publisher"
    t.integer "year"
    t.index ["user_id"], name: "index_book_suggestions_on_user_id", using: :btree
  end

  create_table "books", force: :cascade do |t|
    t.string   "author"
    t.string   "title"
    t.string   "image"
    t.string   "publisher"
    t.string   "year"
    t.string   "genre"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["book_id"], name: "index_comments_on_book_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "reason",                      null: false
    t.string   "action_type"
    t.integer  "action_id"
    t.boolean  "read",        default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "from_id"
    t.integer  "to_id"
    t.string   "body"
    t.index ["action_type", "action_id"], name: "index_notifications_on_action_type_and_action_id", using: :btree
    t.index ["from_id"], name: "index_notifications_on_from_id", using: :btree
    t.index ["to_id"], name: "index_notifications_on_to_id", using: :btree
  end

  create_table "rents", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.date     "from"
    t.date     "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_rents_on_book_id", using: :btree
    t.index ["user_id"], name: "index_rents_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                              null: false
    t.string   "last_name",                               null: false
    t.string   "email",                      default: "", null: false
    t.string   "encrypted_password",         default: "", null: false
    t.string   "verification_code",                       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",              default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "locale"
    t.integer  "unread_notifications_count", default: 0,  null: false
    t.integer  "rents_counter",              default: 0,  null: false
    t.integer  "comments_counter",           default: 0,  null: false
    t.string   "image"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "wishes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_wishes_on_book_id", using: :btree
    t.index ["user_id"], name: "index_wishes_on_user_id", using: :btree
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
