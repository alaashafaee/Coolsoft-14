class JoinTableAssignmentStudent < ActiveRecord::Migration
  def change
    create_join_table :assignments, :students do |t|
      # t.index [:assignment_id, :student_id]
      # t.index [:student_id, :assignment_id]
    end
    add_index :assignments_students, [:assignment_id, :student_id], :unique => true
  end
end
