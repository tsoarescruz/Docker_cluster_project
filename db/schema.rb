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

ActiveRecord::Schema.define(version: 20190513200842) do

  create_table "complaints", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "code"
    t.text     "issues",               limit: 65535
    t.string   "workflow_state"
    t.string   "platform"
    t.integer  "issues_blocked_count"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "product_id"
    t.string   "message"
    t.index ["product_id"], name: "index_complaints_on_product_id", using: :btree
  end

  create_table "issues", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.text     "domain",              limit: 65535
    t.text     "whois",               limit: 65535
    t.integer  "occurrence",                        default: 0
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "platform"
    t.string   "workflow_state"
    t.boolean  "contains_video"
    t.datetime "workflow_changed_at"
    t.text     "title",               limit: 65535
    t.text     "complementary_data",  limit: 65535
    t.integer  "relevance"
    t.string   "thumbnail_url"
  end

  create_table "platforms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "responsible_name"
    t.string   "responsible_email"
    t.string   "additional_message"
    t.boolean  "searchable",         default: false, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "through_dmca",       default: false
    t.string   "link"
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "name"
    t.text     "english_notice_text", limit: 65535
    t.text     "native_notice_text",  limit: 65535
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "link"
  end

  create_table "products_tags", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "product_id"
    t.integer "tag_id"
  end

  create_table "search_configs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "product_id"
    t.text     "extra_params", limit: 65535
    t.boolean  "recurrent",                  default: false
    t.string   "days_of_week"
    t.string   "queries"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "duration"
    t.string   "time"
    t.datetime "date"
    t.boolean  "scheduled"
    t.string   "search_name"
    t.integer  "platform_id"
    t.boolean  "active",                     default: true
    t.index ["platform_id"], name: "index_search_configs_on_platform_id", using: :btree
    t.index ["product_id"], name: "index_search_configs_on_product_id", using: :btree
  end

  create_table "search_results", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "title"
    t.text     "link",       limit: 65535
    t.integer  "status"
    t.string   "from"
    t.integer  "relevance",                default: 0
    t.integer  "occurrence",               default: 1
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "ship_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "platform"
    t.integer  "issue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "product_id"
    t.index ["issue_id"], name: "index_ship_items_on_issue_id", using: :btree
    t.index ["product_id"], name: "index_ship_items_on_product_id", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "name",                   default: "",   null: false
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "role"
    t.boolean  "active",                 default: true
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "version_associations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "version_id"
    t.string  "foreign_key_name", null: false
    t.integer "foreign_key_id"
    t.index ["foreign_key_name", "foreign_key_id"], name: "index_version_associations_on_foreign_key", using: :btree
    t.index ["version_id"], name: "index_version_associations_on_version_id", using: :btree
  end

  create_table "versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "item_type",      limit: 191,        null: false
    t.integer  "item_id",                           null: false
    t.string   "event",                             null: false
    t.string   "whodunnit"
    t.text     "object",         limit: 4294967295
    t.datetime "created_at"
    t.text     "object_changes", limit: 4294967295
    t.integer  "transaction_id"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
    t.index ["transaction_id"], name: "index_versions_on_transaction_id", using: :btree
  end

  create_table "white_lists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.string   "platform"
    t.string   "id_channel"
  end

  add_foreign_key "complaints", "products"
  add_foreign_key "search_configs", "platforms"
  add_foreign_key "search_configs", "products"
  add_foreign_key "ship_items", "issues"
  add_foreign_key "ship_items", "products"
end
