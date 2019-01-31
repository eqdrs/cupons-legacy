# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20190131003745) do

  create_table "coupons", force: :cascade do |t|
    t.string   "code"
    t.integer  "status"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "promotion_id"
  end

  add_index "coupons", ["promotion_id"], name: "index_coupons_on_promotion_id"
  add_index "coupons", ["user_id"], name: "index_coupons_on_user_id"

  create_table "promotion_approvals", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "promotion_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "promotion_approvals", ["promotion_id"], name: "index_promotion_approvals_on_promotion_id"
  add_index "promotion_approvals", ["user_id"], name: "index_promotion_approvals_on_user_id"

  create_table "promotions", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.float    "discount"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "prefix"
    t.integer  "quantity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "duration"
    t.integer  "user_id"
  end

  add_index "promotions", ["user_id"], name: "index_promotions_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
