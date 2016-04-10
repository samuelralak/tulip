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

ActiveRecord::Schema.define(version: 20160409044026) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "bonus", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.decimal  "amount"
    t.date     "date_applicable"
    t.uuid     "painter_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "bonus", ["painter_id"], name: "index_bonus_on_painter_id", using: :btree

  create_table "clients", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "mobile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deduction_installments", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.date     "date"
    t.decimal  "amount"
    t.uuid     "deduction_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "deduction_installments", ["deduction_id"], name: "index_deduction_installments_on_deduction_id", using: :btree

  create_table "deductions", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.date     "date"
    t.string   "reason"
    t.decimal  "amount"
    t.uuid     "painter_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.decimal  "rate",       default: 0.0, null: false
  end

  add_index "deductions", ["painter_id"], name: "index_deductions_on_painter_id", using: :btree

  create_table "employment_types", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.boolean  "is_active",  default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "holidays", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "date"
    t.string   "name"
    t.string   "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoice_items", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "description"
    t.decimal  "amount"
    t.uuid     "invoice_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "invoice_items", ["invoice_id"], name: "index_invoice_items_on_invoice_id", using: :btree

  create_table "invoices", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "invoice_number",                                 null: false
    t.date     "invoice_date"
    t.decimal  "sub_total",       default: 0.0,                  null: false
    t.decimal  "value_added_tax", default: 0.0,                  null: false
    t.decimal  "total",           default: 0.0,                  null: false
    t.uuid     "site_id"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.text     "note",            default: "Supply of paint...", null: false
    t.decimal  "amount",          default: 0.0,                  null: false
  end

  add_index "invoices", ["invoice_number"], name: "index_invoices_on_invoice_number", unique: true, using: :btree
  add_index "invoices", ["site_id"], name: "index_invoices_on_site_id", using: :btree

  create_table "materials", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.date     "date"
    t.decimal  "total_spent"
    t.text     "reason"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "material_name"
    t.uuid     "site_id"
  end

  add_index "materials", ["site_id"], name: "index_materials_on_site_id", using: :btree

  create_table "next_of_kins", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.string   "relation"
    t.string   "telephone"
    t.uuid     "painter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "next_of_kins", ["painter_id"], name: "index_next_of_kins_on_painter_id", using: :btree

  create_table "painter_contacts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "address"
    t.string   "telephone_one"
    t.string   "telephone_two"
    t.string   "telephone_three"
    t.uuid     "painter_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "painter_contacts", ["painter_id"], name: "index_painter_contacts_on_painter_id", using: :btree

  create_table "painter_monthly_incomes", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "painter_id"
    t.string   "month"
    t.string   "year"
    t.decimal  "absent_total", default: 0.0, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.decimal  "basic_pay",    default: 0.0, null: false
  end

  add_index "painter_monthly_incomes", ["painter_id"], name: "index_painter_monthly_incomes_on_painter_id", using: :btree

  create_table "painter_skills", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "painter_id"
    t.uuid     "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "painter_skills", ["painter_id"], name: "index_painter_skills_on_painter_id", using: :btree
  add_index "painter_skills", ["skill_id"], name: "index_painter_skills_on_skill_id", using: :btree

  create_table "painters", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.decimal  "basic_pay",          default: 0.0,  null: false
    t.decimal  "daily_wage",         default: 0.0,  null: false
    t.decimal  "daily_allowance",    default: 0.0,  null: false
    t.uuid     "employment_type_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "is_active",          default: true
  end

  add_index "painters", ["employment_type_id"], name: "index_painters_on_employment_type_id", using: :btree

  create_table "paints", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "month"
    t.string   "year"
    t.decimal  "amount",     default: 0.0, null: false
    t.uuid     "site_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "paints", ["site_id"], name: "index_paints_on_site_id", using: :btree

  create_table "payment_types", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.boolean  "is_active",  default: true, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "payments", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "reference"
    t.decimal  "amount"
    t.uuid     "payment_type_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.date     "payment_date"
    t.string   "bank"
    t.string   "account_number"
    t.uuid     "client_id"
  end

  add_index "payments", ["client_id"], name: "index_payments_on_client_id", using: :btree
  add_index "payments", ["payment_type_id"], name: "index_payments_on_payment_type_id", using: :btree

  create_table "petty_cash_items", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "petty_cash_id"
    t.decimal  "amount",              default: 0.0, null: false
    t.string   "paid_to"
    t.text     "reason"
    t.date     "date"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.decimal  "bal_carried_forward"
  end

  add_index "petty_cash_items", ["petty_cash_id"], name: "index_petty_cash_items_on_petty_cash_id", using: :btree

  create_table "petty_cashes", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "paid_to"
    t.decimal  "amount"
    t.text     "reason"
    t.date     "date_paid"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "source"
    t.decimal  "balance"
    t.decimal  "bal_carried_forward", default: 0.0, null: false
    t.decimal  "total",               default: 0.0, null: false
  end

  create_table "roles", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.uuid     "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "site_agreed_amounts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "internal"
    t.string   "external"
    t.uuid     "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "site_agreed_amounts", ["site_id"], name: "index_site_agreed_amounts_on_site_id", using: :btree

  create_table "site_rates", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "internal"
    t.string   "external"
    t.uuid     "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "site_rates", ["site_id"], name: "index_site_rates_on_site_id", using: :btree

  create_table "site_square_metres", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "internal"
    t.string   "external"
    t.uuid     "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "site_square_metres", ["site_id"], name: "index_site_square_metres_on_site_id", using: :btree

  create_table "sites", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.string   "head"
    t.string   "address"
    t.text     "notes"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.decimal  "start_amount",            default: 0.0,   null: false
    t.decimal  "additional_costs",        default: 0.0,   null: false
    t.string   "client"
    t.string   "city"
    t.string   "mobile"
    t.decimal  "old_paint_amount",        default: 0.0,   null: false
    t.decimal  "initial_labour_amount",   default: 0.0,   null: false
    t.decimal  "initial_material_amount", default: 0.0,   null: false
    t.boolean  "is_active",               default: true,  null: false
    t.boolean  "is_urgent",               default: false, null: false
    t.decimal  "priority",                default: 20.0,  null: false
    t.string   "invoice_name"
  end

  create_table "skills", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.boolean  "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "track_painter_items", force: :cascade do |t|
    t.uuid     "site_id"
    t.date     "date_attended"
    t.decimal  "daily_wage"
    t.uuid     "track_painter_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.decimal  "daily_allowance",  default: 0.0, null: false
  end

  add_index "track_painter_items", ["site_id"], name: "index_track_painter_items_on_site_id", using: :btree
  add_index "track_painter_items", ["track_painter_id"], name: "index_track_painter_items_on_track_painter_id", using: :btree

  create_table "track_painters", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "week_number"
    t.integer  "year"
    t.decimal  "weekly_total"
    t.uuid     "painter_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "notes"
    t.decimal  "weekly_cost"
  end

  add_index "track_painters", ["painter_id", "year", "week_number"], name: "index_track_painters_on_painter_id_and_year_and_week_number", unique: true, using: :btree
  add_index "track_painters", ["painter_id"], name: "index_track_painters_on_painter_id", using: :btree

  create_table "user_types", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.boolean  "is_active",  default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.uuid     "user_type_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["user_type_id"], name: "index_users_on_user_type_id", using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
