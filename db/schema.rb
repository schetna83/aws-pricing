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

ActiveRecord::Schema.define(version: 2020_02_03_101016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "on_demands", force: :cascade do |t|
    t.string "offerTermCode"
    t.datetime "effectiveDate"
    t.json "termAttributes", default: "{}"
    t.bigint "product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_on_demands_on_product_id"
  end

  create_table "price_dimensions", force: :cascade do |t|
    t.string "rateCode"
    t.text "description"
    t.string "beginRange"
    t.string "endRange"
    t.json "pricePerUnit"
    t.string "unit"
    t.text "appliesTo", default: [], array: true
    t.bigint "on_demand_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["on_demand_id"], name: "index_price_dimensions_on_on_demand_id"
  end

  create_table "pricing_services", force: :cascade do |t|
    t.string "offerCode"
    t.string "version"
    t.datetime "publicationDate"
    t.string "region"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "sku"
    t.string "productFamily"
    t.json "p_attributes", default: "{}"
    t.bigint "pricing_service_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pricing_service_id"], name: "index_products_on_pricing_service_id"
    t.index ["sku"], name: "index_products_on_sku"
  end

end
