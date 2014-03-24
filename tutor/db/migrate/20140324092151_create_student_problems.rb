class CreateStudentProblems < ActiveRecord::Migration
  def change
    create_table :student_problems do |t|
      t.integer :student_id
      t.integer :problem_id

      t.timestamps
    end
    add_index :student_problems, [:problem_id,:student_id], :unique => true
  end
end
