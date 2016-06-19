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

ActiveRecord::Schema.define(version: 20160619170113) do

  create_table "categories", force: :cascade do |t|
    t.string   "remote_id"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "categories", ["remote_id"], name: "index_categories_on_remote_id"

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "remote_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "slug"
    t.string   "description"
    t.string   "size_type_color"
    t.integer  "price"
    t.integer  "quantity"
    t.string   "sku"
    t.string   "website"
    t.integer  "category_id"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id"
  add_index "products", ["remote_id"], name: "index_products_on_remote_id"

  create_table "products_tags", id: false, force: :cascade do |t|
    t.integer "product_id"
    t.integer "tag_id"
  end

  add_index "products_tags", ["product_id", "tag_id"], name: "index_products_tags_on_product_id_and_tag_id"

  create_table "tags", force: :cascade do |t|
    t.string   "value",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["value"], name: "index_tags_on_value", unique: true

end
