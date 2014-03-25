class CreateTestCases < ActiveRecord::Migration
  def change
    create_table :test_cases do |t|
      t.string :input
      t.string :output
      t.integer :problem_id
      t.integer :stuff_id

      t.timestamps
    end
  end
end
