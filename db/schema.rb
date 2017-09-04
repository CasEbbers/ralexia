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

ActiveRecord::Schema.define(version: 20170616144847) do

  create_table "enrollment_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "organization_id"
    t.string "name", null: false
    t.integer "nature", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_enrollment_types_on_organization_id"
  end

  create_table "enrollments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.bigint "enrollment_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enrollment_type_id"], name: "index_enrollments_on_enrollment_type_id"
    t.index ["event_id"], name: "index_enrollments_on_event_id"
    t.index ["user_id", "event_id"], name: "index_enrollments_on_user_id_and_event_id", unique: true
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "organizer_id"
    t.string "name", null: false
    t.datetime "starts_at", null: false
    t.datetime "ends_at", null: false
    t.integer "kegs", null: false
    t.boolean "enrollment_closed", default: false
    t.boolean "option", default: false
    t.boolean "risky", default: false
    t.text "bartender_instruction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organizer_id"], name: "index_events_on_organizer_id"
  end

  create_table "events_locations", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "event_id"
    t.bigint "location_id"
    t.index ["event_id", "location_id"], name: "index_events_locations_on_event_id_and_location_id", unique: true
    t.index ["event_id"], name: "index_events_locations_on_event_id"
    t.index ["location_id"], name: "index_events_locations_on_location_id"
  end

  create_table "events_organizations", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "event_id"
    t.bigint "organization_id"
    t.index ["event_id", "organization_id"], name: "index_events_organizations_on_event_id_and_organization_id", unique: true
    t.index ["event_id"], name: "index_events_organizations_on_event_id"
    t.index ["organization_id"], name: "index_events_organizations_on_organization_id"
  end

  create_table "locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.boolean "prevents_conflict", default: true
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "organization_id"
    t.boolean "active", default: true
    t.boolean "bartender", default: false
    t.boolean "planner", default: false
    t.boolean "manager", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_memberships_on_organization_id"
    t.index ["user_id", "organization_id"], name: "index_memberships_on_user_id_and_organization_id", unique: true
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "organizations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "slug"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "logo"
    t.index ["slug"], name: "index_organizations_on_slug", unique: true
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.boolean "admin", default: false
    t.bigint "current_organization_id"
    t.datetime "last_login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["current_organization_id"], name: "index_users_on_current_organization_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "enrollment_types", "organizations"
  add_foreign_key "enrollments", "enrollment_types"
  add_foreign_key "enrollments", "events"
  add_foreign_key "enrollments", "users"
  add_foreign_key "events", "organizations", column: "organizer_id"
  add_foreign_key "memberships", "organizations"
  add_foreign_key "memberships", "users"
  add_foreign_key "users", "organizations", column: "current_organization_id"
end
