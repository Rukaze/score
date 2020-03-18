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

ActiveRecord::Schema.define(version: 2020_03_17_101916) do

  create_table "changeplayers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "inplayer"
    t.string "outplayer"
    t.integer "clock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "game_id"
  end

  create_table "employees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "team"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "period_time"
    t.string "min"
    t.string "sec"
    t.string "opp_name"
    t.integer "opp_score"
  end

  create_table "players", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "team_id"
  end

  create_table "scorings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "kind"
    t.string "player_id"
    t.string "game_id"
    t.string "quarter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "start5s", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "team"
    t.string "p1"
    t.string "p2"
    t.string "p3"
    t.string "p4"
    t.string "p5"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stuts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "player_id"
    t.string "game_id"
    t.integer "FGmake"
    t.integer "FGmiss"
    t.integer "Deepmake"
    t.integer "Deepmiss"
    t.integer "FTmake"
    t.integer "FTmiss"
    t.integer "DefReb"
    t.integer "OffReb"
    t.integer "Assist"
    t.integer "Block"
    t.integer "steal"
    t.integer "TO"
    t.integer "PF"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "playingtime"
    t.string "player_name"
    t.string "team_id"
    t.integer "point"
  end

  create_table "teams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "team_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "username", limit: 191, null: false
    t.string "email", limit: 191, null: false
    t.string "password_digest", limit: 191
    t.integer "level"
    t.string "salt", limit: 191
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
