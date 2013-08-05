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

ActiveRecord::Schema.define(version: 20130805204633) do

  create_table "factor_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "factor_selections", force: true do |t|
    t.integer  "user_id"
    t.integer  "factor_id"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "factor_selections", ["factor_id"], name: "index_factor_selections_on_factor_id"
  add_index "factor_selections", ["user_id"], name: "index_factor_selections_on_user_id"

  create_table "factors", force: true do |t|
    t.string   "slug",               null: false
    t.string   "description",        null: false
    t.integer  "factor_category_id"
    t.string   "onet_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "factors", ["factor_category_id"], name: "index_factors_on_factor_category_id"

  create_table "phase_section_mappings", force: true do |t|
    t.integer  "phase_id"
    t.integer  "section_id"
    t.integer  "row_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phase_section_mappings", ["phase_id"], name: "index_phase_section_mappings_on_phase_id"
  add_index "phase_section_mappings", ["section_id"], name: "index_phase_section_mappings_on_section_id"

  create_table "phases", force: true do |t|
    t.string   "name",       null: false
    t.string   "slug",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "program_phase_mappings", force: true do |t|
    t.integer  "phase_id"
    t.integer  "program_id"
    t.integer  "row_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "program_phase_mappings", ["phase_id"], name: "index_program_phase_mappings_on_phase_id"
  add_index "program_phase_mappings", ["program_id"], name: "index_program_phase_mappings_on_program_id"

  create_table "programs", force: true do |t|
    t.string   "name",                      null: false
    t.boolean  "active",     default: true
    t.string   "slug",                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "name",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
