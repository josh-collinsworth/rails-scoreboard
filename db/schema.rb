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

ActiveRecord::Schema.define(version: 2020_04_13_185614) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_participants", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "participant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "score", default: 0, null: false
    t.index ["game_id"], name: "index_game_participants_on_game_id"
    t.index ["participant_id"], name: "index_game_participants_on_participant_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.json "options", default: {"increment"=>1, "include_increment_by_one"=>false, "call_players"=>true, "prepend"=>"", "append"=>"", "add_reset"=>false, "add_double"=>false, "add_halve"=>false}
    t.index ["name"], name: "index_games_on_name"
  end

  create_table "participants", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_participants_on_name"
  end

  create_table "participants_in_games", force: :cascade do |t|
    t.bigint "games_id", null: false
    t.bigint "participants_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["games_id"], name: "index_participants_in_games_on_games_id"
    t.index ["participants_id"], name: "index_participants_in_games_on_participants_id"
  end

  add_foreign_key "game_participants", "games"
  add_foreign_key "game_participants", "participants"
  add_foreign_key "participants_in_games", "games", column: "games_id"
  add_foreign_key "participants_in_games", "participants", column: "participants_id"
end
