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

ActiveRecord::Schema.define(version: 20140325191405) do

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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses_lecturers", id: false, force: true do |t|
    t.integer "course_id",   null: false
    t.integer "lecturer_id", null: false
  end

  add_index "courses_lecturers", ["course_id", "lecturer_id"], name: "index_courses_lecturers_on_course_id_and_lecturer_id", unique: true

  create_table "courses_students", id: false, force: true do |t|
    t.integer "course_id",  null: false
    t.integer "student_id", null: false
  end

  add_index "courses_students", ["course_id", "student_id"], name: "index_courses_students_on_course_id_and_student_id", unique: true

  create_table "debuggers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discussion_boards", force: true do |t|
    t.string   "title"
    t.boolean  "activated",  default: false
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
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lecturers", force: true do |t|
    t.string   "degree"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lecturers_teaching_assistants", id: false, force: true do |t|
    t.integer "teaching_assistant_id", null: false
    t.integer "lecturer_id",           null: false
  end

  add_index "lecturers_teaching_assistants", ["teaching_assistant_id", "lecturer_id"], name: "TALecturers", unique: true

  create_table "method_constraints", force: true do |t|
    t.string   "method_name"
    t.integer  "model_answer_id"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "method_parameters", force: true do |t|
    t.string   "parameter"
    t.integer  "model_answer_id"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "model_answers", force: true do |t|
    t.text     "answer"
    t.integer  "problem_id"
    t.integer  "staff_id"
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
    t.integer  "success_attempts"
    t.integer  "failure_attempts"
    t.integer  "views_count"
    t.integer  "time_limit"
    t.integer  "track_id"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recommendations", force: true do |t|
    t.integer  "problem_id"
    t.integer  "student_id"
    t.integer  "recommender_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recommendations", ["problem_id", "student_id", "recommender_id"], name: "recom_problems", unique: true

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
    t.integer  "status"
    t.integer  "student_id"
    t.integer  "problem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffs", force: true do |t|
    t.string   "department"
    t.string   "staff"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "staff_id"
    t.integer  "problem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "order_factor"
    t.integer  "course_id"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tracks", force: true do |t|
    t.string   "title"
    t.integer  "difficulty"
    t.integer  "views_count"
    t.integer  "topic_id"
    t.integer  "staff_id"
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
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
