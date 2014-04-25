class CreateProblemOpeningTimes < ActiveRecord::Migration
  def change
    create_table :problem_opening_times do |t|
      t.time :start_time
      t.integer :student_id
      t.integer :problem_id

      t.timestamps
    end
    add_index :problem_opening_times, [:student_id, :problem_id], unique: true
  end
end
