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

ActiveRecord::Schema.define(:version => 20131125071824) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "roles_mask"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "attendees", :force => true do |t|
    t.string   "name"
    t.date     "date_of_birth"
    t.string   "gender"
    t.string   "religion"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.string   "office_name"
    t.string   "office_address"
    t.string   "office_phone"
    t.string   "job_title"
    t.string   "campus_name"
    t.string   "campus_address"
    t.string   "campus_phone"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "place_of_birth"
    t.string   "training_location"
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "cell_number"
    t.integer  "campus_id"
    t.string   "book_status"
  end

  add_index "attendees", ["email"], :name => "index_attendees_on_email", :unique => true
  add_index "attendees", ["reset_password_token"], :name => "index_attendees_on_reset_password_token", :unique => true

  create_table "bank_accounts", :force => true do |t|
    t.string   "bank_name"
    t.string   "account_holder"
    t.string   "bank_branch"
    t.string   "account_number"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "blogs", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "writer"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "campus", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.string   "address"
    t.string   "phone"
  end

  create_table "events", :force => true do |t|
    t.string   "body"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "news", :force => true do |t|
    t.string   "body"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "orders", :force => true do |t|
    t.string   "status"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "attendee_id"
    t.string   "payment_type"
    t.integer  "payment_amount"
    t.integer  "payment_term_id"
    t.integer  "payment_code"
  end

  create_table "payment_code_counters", :force => true do |t|
    t.integer  "index"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "order_id"
  end

  create_table "payment_terms", :force => true do |t|
    t.string   "name"
    t.integer  "amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "label"
  end

  add_index "payment_terms", ["name"], :name => "index_payment_terms_on_name", :unique => true

  create_table "payment_types", :force => true do |t|
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "name"
    t.string   "type"
    t.string   "account_number"
    t.string   "account_holder"
    t.string   "branch_name"
  end

  create_table "pretests", :force => true do |t|
    t.text     "question"
    t.text     "answer_one"
    t.text     "answer_two"
    t.text     "answer_three"
    t.text     "answer_four"
    t.integer  "correct_answer"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.text     "answer_five"
  end

  create_table "profiles", :force => true do |t|
    t.string   "name"
    t.string   "bio"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "avatar"
  end

  create_table "test_results", :force => true do |t|
    t.integer  "attendee_id"
    t.integer  "score"
    t.integer  "number_of_question"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "tests", :force => true do |t|
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "question"
    t.string   "answer_one"
    t.string   "answer_two"
    t.string   "answer_three"
    t.string   "answer_four"
    t.integer  "correct_answer"
  end

  create_table "training_locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "price"
  end

  create_table "training_prices", :force => true do |t|
    t.integer  "training_location_id"
    t.integer  "price"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "training_schedules", :force => true do |t|
    t.integer  "training_location_id"
    t.date     "training_date"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "quota"
  end

  create_table "trainings", :force => true do |t|
    t.integer  "attendee_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "training_location_id"
    t.integer  "amount_paid"
    t.integer  "amount_unpaid"
    t.integer  "training_schedule_id"
    t.string   "type"
    t.integer  "payment_type_id"
    t.integer  "payment_code"
    t.string   "description"
    t.string   "status"
  end

  create_table "traning_locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
