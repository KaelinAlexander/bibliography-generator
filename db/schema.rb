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

ActiveRecord::Schema.define(version: 2020_08_21_173327) do

  create_table "authors", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "author_type"
    t.integer "text_id"
  end

  create_table "bibliographies", force: :cascade do |t|
    t.string "name"
    t.string "style"
    t.string "use"
    t.integer "user_id"
  end

  create_table "citations", force: :cascade do |t|
    t.string "citation_location"
    t.string "citation_type"
    t.integer "bibliography_id"
    t.integer "text_id"
    t.index "\"bibliography\", \"text\"", name: "index_citations_on_bibliography_and_text", unique: true
  end

  create_table "texts", force: :cascade do |t|
    t.string "title"
    t.string "subtitle"
    t.string "editor"
    t.string "translator"
    t.integer "edition"
    t.string "publisher"
    t.string "pub_state"
    t.string "pub_city"
    t.integer "pub_year"
    t.text "notes"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

end
