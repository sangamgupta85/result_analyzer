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

ActiveRecord::Schema.define(version: 2023_07_21_133023) do

  create_table "daily_result_stats", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.date "daily_result_stat_date"
    t.string "subject"
    t.decimal "daily_low", precision: 16, scale: 2
    t.decimal "daily_high", precision: 16, scale: 2
    t.integer "result_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject", "daily_result_stat_date"], name: "idx_on_subject_and_daily_result_stat_date", unique: true
  end

  create_table "monthly_averages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.date "monthly_average_date"
    t.string "subject"
    t.decimal "monthly_avg_low", precision: 16, scale: 2
    t.decimal "monthly_avg_high", precision: 16, scale: 2
    t.integer "monthly_result_count_used"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject", "monthly_average_date"], name: "idx_on_subject_and_monthly_average_date", unique: true
  end

  create_table "results_data", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "subject"
    t.datetime "timestamp"
    t.decimal "marks", precision: 16, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
