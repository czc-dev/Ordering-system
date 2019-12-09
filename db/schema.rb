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

ActiveRecord::Schema.define(version: 2019_09_25_013938) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "combinations", id: false, force: :cascade do |t|
    t.bigint "exam_set_id"
    t.bigint "exam_item_id"
    t.index ["exam_item_id"], name: "index_combinations_on_exam_item_id"
    t.index ["exam_set_id"], name: "index_combinations_on_exam_set_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "fullname"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_employees_on_discarded_at"
  end

  create_table "exam_items", force: :cascade do |t|
    t.string "abbreviation"
    t.string "formal_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_exam_items_on_discarded_at"
  end

  create_table "exam_sets", force: :cascade do |t|
    t.string "set_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_exam_sets_on_discarded_at"
  end

  create_table "exams", force: :cascade do |t|
    t.boolean "canceled"
    t.integer "status_id"
    t.boolean "urgent"
    t.bigint "exam_item_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sample"
    t.string "result"
    t.datetime "booked_at"
    t.datetime "discarded_at"
    t.string "appraisal"
    t.boolean "submitted"
    t.index ["discarded_at"], name: "index_exams_on_discarded_at"
    t.index ["exam_item_id"], name: "index_exams_on_exam_item_id"
    t.index ["order_id"], name: "index_exams_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.boolean "canceled"
    t.datetime "may_result_at"
    t.integer "status_id"
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_orders_on_discarded_at"
    t.index ["patient_id"], name: "index_orders_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.datetime "birth"
    t.integer "gender_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_patients_on_discarded_at"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "exams", "exam_items"
  add_foreign_key "exams", "orders"
  add_foreign_key "orders", "patients"
end
