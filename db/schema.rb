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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140419223405) do

  create_table "cinemas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "address"
    t.string   "postcode"
    t.integer  "distance"
    t.integer  "duration"
  end

  create_table "cinemas_films", :force => true do |t|
    t.integer "cinema_id"
    t.integer "film_id"
  end

  create_table "films", :force => true do |t|
    t.integer  "edi"
    t.string   "title"
    t.integer  "cineworld_film_id"
    t.string   "poster_url"
    t.string   "still_url"
    t.string   "film_url"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "notified",          :default => false
    t.boolean  "watched",           :default => false
  end

  create_table "observed_cinemas", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "cinema_id"
  end

  create_table "performances", :force => true do |t|
    t.integer  "film_id"
    t.integer  "cinema_id"
    t.string   "performance_type"
    t.string   "booking_url"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.datetime "time"
  end

  create_table "reviews", :force => true do |t|
    t.integer  "film_id"
    t.text     "plot"
    t.string   "languages"
    t.string   "director"
    t.string   "genres"
    t.string   "url"
    t.integer  "length"
    t.float    "rating"
    t.text     "plot_summary"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "trailer_url"
    t.text     "youtube_html"
  end

  add_index "reviews", ["film_id"], :name => "index_reviews_on_film_id"

end
