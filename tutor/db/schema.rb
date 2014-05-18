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

ActiveRecord::Schema.define(version: 20140515223322) do

  create_table "acknowledgements", force: true do |t|
    t.string   "message"
    t.integer  "course_id"
    t.integer  "student_id"
    t.integer  "lecturer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "assignment_problems", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "final_grade",   default: 0
    t.integer  "assignment_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignment_problems", ["title", "assignment_id"], name: "index_assignment_problems_on_title_and_assignment_id", unique: true

  create_table "assignments", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "due_date"
    t.boolean  "publish"
    t.integer  "course_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["title", "course_id"], name: "index_assignments_on_title_and_course_id", unique: true

  create_table "attempts", force: true do |t|
    t.integer  "student_id"
    t.integer  "problem_id"
    t.boolean  "failure",    default: false
    t.boolean  "success",    default: false
    t.boolean  "incomplete", default: false
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

  create_table "contest_progresses", force: true do |t|
    t.integer  "contest_id"
    t.integer  "student_id"
    t.integer  "cproblem_id"
    t.integer  "trials"
    t.boolean  "status"
    t.integer  "trials"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contest_progresses", ["contest_id", "student_id", "cproblem_id"], name: "ConProgress", unique: true

  create_table "contests", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "incomplete"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "course_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contests_cproblems", id: false, force: true do |t|
    t.integer "contest_id",  null: false
    t.integer "cproblem_id", null: false
  end

  add_index "contests_cproblems", ["contest_id", "cproblem_id"], name: "index_contests_cproblems_on_contest_id_and_cproblem_id", unique: true

  create_table "contests_students", id: false, force: true do |t|
    t.integer "contest_id", null: false
    t.integer "student_id", null: false
  end

  add_index "contests_students", ["contest_id", "student_id"], name: "index_contests_students_on_contest_id_and_student_id", unique: true

  create_table "course_students", force: true do |t|
    t.boolean  "share",      default: false
    t.integer  "course_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_students", ["course_id", "student_id"], name: "index_course_students_on_course_id_and_student_id", unique: true

  create_table "courses", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "year"
    t.integer  "semester"
    t.string   "university"
    t.text     "description"
    t.boolean  "visible",     default: false
    t.boolean  "incomplete",  default: true
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses_lecturers", id: false, force: true do |t|
    t.integer "course_id",   null: false
    t.integer "lecturer_id", null: false
  end

  add_index "courses_lecturers", ["course_id", "lecturer_id"], name: "index_courses_lecturers_on_course_id_and_lecturer_id", unique: true

  create_table "courses_teaching_assistants", id: false, force: true do |t|
    t.integer "course_id",             null: false
    t.integer "teaching_assistant_id", null: false
  end

  add_index "courses_teaching_assistants", ["course_id", "teaching_assistant_id"], name: "TACourses", unique: true

  create_table "cproblems", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "time_limit"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "grades", force: true do |t|
    t.integer  "problem_id"
    t.integer  "student_id"
    t.integer  "grade"
    t.integer  "editor_id"
    t.string   "editor_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "grades", ["student_id", "problem_id"], name: "index_grades_on_student_id_and_problem_id", unique: true

  create_table "hints", force: true do |t|
    t.text     "message"
    t.boolean  "category"
    t.integer  "time"
    t.integer  "submission_counter"
    t.integer  "model_answer_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lecturers", force: true do |t|
    t.string   "name"
    t.date     "dob"
    t.string   "profile_image"
    t.boolean  "gender"
    t.string   "degree"
    t.string   "department"
    t.string   "university"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "lecturers", ["confirmation_token"], name: "index_lecturers_on_confirmation_token", unique: true
  add_index "lecturers", ["email"], name: "index_lecturers_on_email", unique: true
  add_index "lecturers", ["reset_password_token"], name: "index_lecturers_on_reset_password_token", unique: true

  create_table "lecturers_teaching_assistants", id: false, force: true do |t|
    t.integer "teaching_assistant_id", null: false
    t.integer "lecturer_id",           null: false
  end

  add_index "lecturers_teaching_assistants", ["teaching_assistant_id", "lecturer_id"], name: "TALecturers", unique: true

  create_table "method_constraints", force: true do |t|
    t.string   "method_name"
    t.string   "method_return"
    t.integer  "model_answer_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "method_parameters", force: true do |t|
    t.string   "parameter"
    t.string   "params_type"
    t.integer  "method_constraint_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "model_answers", force: true do |t|
    t.string   "title"
    t.text     "answer"
    t.integer  "problem_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: true do |t|
    t.string   "content"
    t.integer  "line"
    t.integer  "solution_id"
    t.integer  "owner_id"
    t.string   "owner_type"
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

  create_table "notifications", force: true do |t|
    t.string   "message",                       null: false
    t.boolean  "seen",          default: false
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.string   "img"
    t.text     "content"
    t.integer  "views_count"
    t.integer  "discussion_board_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "problem_opening_times", force: true do |t|
    t.integer  "time"
    t.integer  "student_id"
    t.integer  "problem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "problem_opening_times", ["student_id", "problem_id"], name: "index_problem_opening_times_on_student_id_and_problem_id", unique: true

  create_table "problems", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "snippet"
    t.integer  "views_count", default: 0
    t.integer  "time_limit",  default: 0
    t.integer  "track_id"
    t.boolean  "fill_gaps",   default: false
    t.boolean  "incomplete",  default: true
    t.boolean  "seen",        default: false
    t.boolean  "duplicated",  default: false
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "problems", ["track_id", "title"], name: "index_problems_on_track_id_and_title", unique: true

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
    t.string   "img"
    t.integer  "post_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources", force: true do |t|
    t.text     "description"
    t.string   "link"
    t.string   "link_type"
    t.string   "img"
    t.integer  "course_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rich_rich_files", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rich_file_file_name"
    t.string   "rich_file_content_type"
    t.integer  "rich_file_file_size"
    t.datetime "rich_file_updated_at"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.text     "uri_cache"
    t.string   "simplified_type",        default: "file"
  end

  create_table "solutions", force: true do |t|
    t.text     "code"
    t.integer  "length",       default: 0
    t.integer  "status"
    t.integer  "time",         default: 0
    t.text     "class_name"
    t.integer  "student_id"
    t.integer  "problem_id"
    t.string   "problem_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string   "name"
    t.date     "dob"
    t.string   "profile_image"
    t.boolean  "gender"
    t.string   "university"
    t.string   "faculty"
    t.string   "major"
    t.integer  "semester"
    t.boolean  "advising",               default: false
    t.boolean  "probation",              default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "students", ["confirmation_token"], name: "index_students_on_confirmation_token", unique: true
  add_index "students", ["email"], name: "index_students_on_email", unique: true
  add_index "students", ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true

  create_table "tags", force: true do |t|
    t.string   "name"
    t.integer  "tager_id"
    t.string   "tager_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teaching_assistants", force: true do |t|
    t.string   "name"
    t.date     "dob"
    t.string   "profile_image"
    t.boolean  "gender"
    t.string   "graduated_from"
    t.integer  "graduated_year"
    t.string   "department"
    t.string   "university"
    t.string   "degree"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "teaching_assistants", ["confirmation_token"], name: "index_teaching_assistants_on_confirmation_token", unique: true
  add_index "teaching_assistants", ["email"], name: "index_teaching_assistants_on_email", unique: true
  add_index "teaching_assistants", ["reset_password_token"], name: "index_teaching_assistants_on_reset_password_token", unique: true

  create_table "test_cases", force: true do |t|
    t.string   "input"
    t.string   "output"
    t.integer  "model_answer_id"
    t.integer  "problem_id"
    t.integer  "cproblem_id"
    t.integer  "assignment_problem_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "order_factor"
    t.integer  "course_id"
    t.integer  "lecturer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "track_progressions", force: true do |t|
    t.integer  "level"
    t.integer  "student_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "track_progressions", ["student_id", "topic_id"], name: "index_track_progressions_on_student_id_and_topic_id", unique: true

  create_table "tracks", force: true do |t|
    t.string   "title"
    t.integer  "difficulty"
    t.integer  "views_count", default: 0
    t.integer  "topic_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "variable_constraints", force: true do |t|
    t.string   "variable_name"
    t.string   "variable_type"
    t.integer  "model_answer_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
