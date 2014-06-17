class JoinTableCourseTeachingAssistant < ActiveRecord::Migration
  def change
    create_join_table :courses, :teaching_assistants do |t|
      # t.index [:course_id, :teaching_assistant_id]
      # t.index [:teaching_assistant_id, :course_id]
    end
    add_index :courses_teaching_assistants, [:course_id,:teaching_assistant_id], :unique => true, :name => "TACourses"
  end
end
