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

ActiveRecord::Schema.define(version: 2018_10_31_005813) do

  create_table "combinations", id: false, force: :cascade do |t|
    t.integer "inspection_set_id"
    t.integer "inspection_detail_id"
    t.index ["inspection_detail_id"], name: "index_combinations_on_inspection_detail_id"
    t.index ["inspection_set_id"], name: "index_combinations_on_inspection_set_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "fullname"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inspection_details", force: :cascade do |t|
    t.string "abbreviation"
    t.string "formal_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inspection_sets", force: :cascade do |t|
    t.string "set_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inspections", force: :cascade do |t|
    t.boolean "canceled"
    t.integer "status_id"
    t.boolean "urgent"
    t.integer "inspection_detail_id"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inspection_detail_id"], name: "index_inspections_on_inspection_detail_id"
    t.index ["order_id"], name: "index_inspections_on_order_id"
  end

  create_table "logs", force: :cascade do |t|
    t.string "content"
    t.integer "order_id"
    t.integer "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_logs_on_employee_id"
  end

  create_table "orders", force: :cascade do |t|
    t.boolean "canceled"
    t.datetime "may_result_at"
    t.integer "status_id"
    t.integer "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_orders_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.integer "age"
    t.datetime "birth"
    t.integer "gender_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "results", force: :cascade do |t|
    t.string "content"
    t.integer "inspection_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inspection_id"], name: "index_results_on_inspection_id"
  end

  create_table "samples", force: :cascade do |t|
    t.text "condition"
    t.integer "inspection_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inspection_id"], name: "index_samples_on_inspection_id"
  end

end
