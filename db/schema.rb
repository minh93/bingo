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

ActiveRecord::Schema.define(version: 20151015083509) do

  create_table "deals", force: true do |t|
    t.string   "deal"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number_of_turn"
    t.string   "tempwinner_number"
    t.string   "winnumber_type_2"
    t.string   "winnumber_type_3"
    t.string   "winnumber_type_4"
    t.string   "not_exist_deal"
    t.integer  "turn"
  end

  create_table "players", force: true do |t|
    t.string   "name"
    t.boolean  "reach_status"
    t.boolean  "bingo_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "card"
    t.string   "row"
    t.string   "column"
    t.string   "diagonal"
    t.string   "card_status"
    t.integer  "deal_id"
    t.integer  "player_point"
  end

  add_index "players", ["deal_id", "name"], name: "index_players_on_deal_id_and_name", unique: true

end
