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

ActiveRecord::Schema.define(version: 20140324092151) do

  create_table "admins", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "code_editors", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "compile_errors", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "year"
    t.integer  "semester"
    t.text     "description"
    t.boolean  "enable_discussion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "debuggers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discussion_boards", force: true do |t|
    t.string   "title"
    t.boolean  "activated"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hints", force: true do |t|
    t.text     "message"
    t.boolean  "type"
    t.integer  "time"
    t.integer  "submission_counter"
    t.integer  "model_answer_id"
    t.integer  "stuff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lecturers", force: true do |t|
    t.string   "degree"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "method_constraints", force: true do |t|
    t.string   "method_name"
    t.integer  "model_answer_id"
    t.integer  "stuff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "method_parameters", force: true do |t|
    t.string   "parameter"
    t.integer  "model_answer_id"
    t.integer  "stuff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "model_answers", force: true do |t|
    t.text     "answer"
    t.integer  "problem_id"
    t.integer  "stuff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notification_mails", force: true do |t|
    t.string   "subject"
    t.string   "email"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.text     "content"
    t.integer  "views_count"
    t.integer  "discussion_board_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "problems", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "success_attpemts"
    t.integer  "failure_attempts"
    t.integer  "views_count"
    t.integer  "time_limit"
    t.integer  "track_id"
    t.integer  "stuff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recommend_problems", force: true do |t|
    t.integer  "problem_id"
    t.integer  "student_id"
    t.integer  "recommender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recommend_problems", ["problem_id", "student_id"], name: "recom_problems", unique: true

  create_table "replies", force: true do |t|
    t.text     "content"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "solutions", force: true do |t|
    t.text     "code"
    t.integer  "length"
    t.boolean  "status"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_courses", force: true do |t|
    t.string   "student_id"
    t.string   "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "student_courses", ["course_id", "student_id"], name: "index_student_courses_on_course_id_and_student_id", unique: true

  create_table "student_problems", force: true do |t|
    t.integer  "student_id"
    t.integer  "problem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "student_problems", ["problem_id", "student_id"], name: "index_student_problems_on_problem_id_and_student_id", unique: true

  create_table "students", force: true do |t|
    t.string   "faculty"
    t.string   "major"
    t.integer  "year"
    t.integer  "semester"
    t.boolean  "advising"
    t.boolean  "probation"
    t.integer  "failure_attempts"
    t.integer  "success_attempts"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stuff_courses", force: true do |t|
    t.integer  "course_id"
    t.integer  "stuff_id"
    t.boolean  "owner",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stuff_courses", ["course_id", "stuff_id"], name: "index_stuff_courses_on_course_id_and_stuff_id", unique: true

  create_table "stuffs", force: true do |t|
    t.string   "department"
    t.string   "stuff"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teaching_assistants", force: true do |t|
    t.string   "graduated_from"
    t.integer  "graduated_year"
    t.boolean  "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test_cases", force: true do |t|
    t.string   "input"
    t.string   "output"
    t.integer  "model_answer_id"
    t.integer  "stuff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "order_factor"
    t.integer  "course_id"
    t.integer  "stuff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tracks", force: true do |t|
    t.string   "title"
    t.integer  "difficulty"
    t.integer  "views_count"
    t.integer  "topic_id"
    t.integer  "stuff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.date     "dob"
    t.integer  "age"
    t.string   "profile_image"
    t.boolean  "gender"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "variable_constraints", force: true do |t|
    t.string   "variable_name"
    t.string   "type"
    t.integer  "model_answer_id"
    t.integer  "stuff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
