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

ActiveRecord::Schema.define(version: 2020_12_14_154814) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.integer "harvest_id"
    t.integer "contracted_hours"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "contractor_invoices", force: :cascade do |t|
    t.bigint "developer_id", null: false
    t.float "total_hours"
    t.float "cost"
    t.datetime "submitted_at"
    t.datetime "approved_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["developer_id"], name: "index_contractor_invoices_on_developer_id"
  end

  create_table "developers", force: :cascade do |t|
    t.string "name"
    t.string "harvest_id"
    t.datetime "last_report"
    t.float "rate_per_hour"
    t.integer "contract_type"
    t.integer "contract_long"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "holydays", force: :cascade do |t|
    t.string "name"
    t.date "official_day"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "harvest_id"
    t.bigint "client_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.float "total_hours"
    t.float "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_invoices_on_client_id"
  end

  create_table "issue_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "issues", force: :cascade do |t|
    t.bigint "issue_type_id", null: false
    t.string "issuer_type"
    t.bigint "issuer_id"
    t.string "trackable_type"
    t.bigint "trackable_id"
    t.string "comment"
    t.datetime "solved_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["issue_type_id"], name: "index_issues_on_issue_type_id"
    t.index ["issuer_type", "issuer_id"], name: "index_issues_on_issuer_type_and_issuer_id"
    t.index ["trackable_type", "trackable_id"], name: "index_issues_on_trackable_type_and_trackable_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "harvest_id"
    t.string "pivotal_id"
    t.string "montly_hours"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["var"], name: "index_settings_on_var", unique: true
  end

  create_table "time_entries", force: :cascade do |t|
    t.bigint "developer_id", null: false
    t.boolean "billable"
    t.bigint "project_id"
    t.string "harvest_id"
    t.string "pivotal_id"
    t.string "description_long"
    t.boolean "running"
    t.boolean "invoiced"
    t.float "total_hours"
    t.boolean "approved"
    t.datetime "reported_at"
    t.datetime "last_modify"
    t.datetime "started_at"
    t.datetime "ended_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "live_reported"
    t.index ["developer_id"], name: "index_time_entries_on_developer_id"
    t.index ["project_id"], name: "index_time_entries_on_project_id"
  end

  create_table "time_reports", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "to"
    t.datetime "approved_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_time_reports_on_project_id"
  end

  add_foreign_key "contractor_invoices", "developers"
  add_foreign_key "invoices", "clients"
  add_foreign_key "issues", "issue_types"
  add_foreign_key "time_entries", "developers"
  add_foreign_key "time_entries", "projects"
  add_foreign_key "time_reports", "projects"
end
