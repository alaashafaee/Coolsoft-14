class CreateTestCases < ActiveRecord::Migration
  def change
    create_table :test_cases do |t|
      t.string :input
      t.string :output
      t.integer :model_answer_id
      t.integer :problem_id
      t.integer :cproblem_id
      t.integer :assignment_problem_id

      t.references :owner, polymorphic: true
      t.timestamps
    end
  end
end
