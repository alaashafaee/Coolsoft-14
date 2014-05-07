class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.integer :assignment_id
      t.integer :problem_id
      t.integer :student_id
      t.integer :grade

      t.references :editor, polymorphic: true
      t.timestamps
    end
    add_index :grades, [:assignment_id, :student_id, :problem_id], :unique => true
  end
end
