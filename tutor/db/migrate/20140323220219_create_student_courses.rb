class CreateStudentCourses < ActiveRecord::Migration
  def change
    create_table :student_courses do |t|
      t.string :student_id
      t.string :course_id

      t.timestamps
    end
    add_index :student_courses, [:course_id,:student_id], :unique => true
  end
end
