class CreateJoinTableCourseLecturer < ActiveRecord::Migration
  def change
    create_join_table :courses, :lecturers do |t|
      # t.index [:course_id, :lecturer_id]
      # t.index [:lecturer_id, :course_id]
    end
    add_index(:courses_lecturers, [:course_id, :lecturer_id], :unique => true)
  end
end
