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

ActiveRecord::Schema.define(version: 20150917220323) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administrators", force: :cascade do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.string   "correo"
    t.string   "contrasena"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contests", force: :cascade do |t|
    t.string   "nombre"
    t.string   "banner"
    t.string   "url"
    t.string   "descripcion"
    t.string   "premio"
    t.datetime "fechainicio"
    t.datetime "fechafin"
    t.integer  "administrator_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "contests", ["administrator_id"], name: "index_contests_on_administrator_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.string   "correo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "fechacreacion"
    t.string   "urloriginal"
    t.string   "urlconvertido"
    t.string   "estado"
    t.string   "descripcion"
    t.integer  "contest_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "videos", ["contest_id"], name: "index_videos_on_contest_id", using: :btree
  add_index "videos", ["user_id"], name: "index_videos_on_user_id", using: :btree

  add_foreign_key "contests", "administrators"
  add_foreign_key "videos", "contests"
  add_foreign_key "videos", "users"
end