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

ActiveRecord::Schema.define(:version => 20130516130106) do

  create_table "cartridges", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "cartridge_type"
    t.integer  "make_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "clients", :force => true do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.string   "streetNumber"
    t.string   "streetName"
    t.string   "city"
    t.string   "postalCode"
    t.boolean  "isVendor"
    t.string   "companyName"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "makes", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "image_url"
  end

  create_table "tasks", :force => true do |t|
    t.date     "checkinDate"
    t.date     "estimatedCompletitionDate"
    t.boolean  "isComplete"
    t.date     "completitionDate"
    t.decimal  "price"
    t.integer  "client_id"
    t.integer  "cartridge_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

end
