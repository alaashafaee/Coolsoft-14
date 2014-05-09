class CreateAssignmentProblems < ActiveRecord::Migration
  def change
    create_table :assignment_problems do |t|
      t.string :title
      t.text :description
      t.integer :grade, default: 0

      t.integer :assignment_id
      t.references :owner, polymorphic: true
      t.timestamps
    end
  end
end
