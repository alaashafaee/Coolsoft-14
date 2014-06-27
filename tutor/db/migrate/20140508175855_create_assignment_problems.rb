class CreateAssignmentProblems < ActiveRecord::Migration
  def change
    create_table :assignment_problems do |t|
      t.string :title
      t.text :description
      t.integer :final_grade, default: 0
      t.boolean :incomplete, default: true

      t.integer :assignment_id
      t.references :owner, polymorphic: true
      t.timestamps
    end
    add_index :assignment_problems, [:title, :assignment_id], unique: true
  end
end
