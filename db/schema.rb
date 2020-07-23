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

ActiveRecord::Schema.define(version: 202000708225324) do

  create_table "dwolla_merchants", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "account_type"
    t.string "ip_address"
    t.string "business_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "merchant_account_id"
  end

  create_table "dwolla_securities", force: :cascade do |t|
    t.string "target"
    t.string "key"
    t.string "secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fund_transfers", force: :cascade do |t|
    t.string "target_account_id"
    t.string "source_account_id"
    t.string "transfer_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mechant_accounts", force: :cascade do |t|
    t.string "routing_number"
    t.string "account_number"
    t.string "bank_account_type"
    t.string "name_for_account"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dwolla_merchant_account_id"
  end

  create_table "merchant_accounts", force: :cascade do |t|
    t.string "routing_number"
    t.string "account_number"
    t.string "bank_account_type"
    t.string "name_for_account"
    t.string "dwolla_merchant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transfer_funds", force: :cascade do |t|
    t.string "target_account_id"
    t.string "source_account_id"
    t.string "transfer_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
