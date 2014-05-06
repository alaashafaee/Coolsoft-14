class CreateContestProgresses < ActiveRecord::Migration
  def change
    create_table :contest_progresses do |t|
      t.integer :contest_id
      t.integer :student_id
      t.integer :problem_id
      t.boolean :status

      t.timestamps
    end
  end
end
