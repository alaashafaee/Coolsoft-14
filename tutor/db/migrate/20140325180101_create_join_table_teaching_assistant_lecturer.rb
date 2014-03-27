class CreateJoinTableTeachingAssistantLecturer < ActiveRecord::Migration
  def change
    create_join_table :teaching_assistants, :lecturers do |t|
      # t.index [:teaching_assistant_id, :lecturer_id]
      # t.index [:lecturer_id, :teaching_assistant_id]
    end
    add_index(:lecturers_teaching_assistants, [:teaching_assistant_id, :lecturer_id], :unique => true, :name => "TALecturers")
  end
end
