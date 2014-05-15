class CreateContestProgresses < ActiveRecord::Migration
  def change
    create_table :contest_progresses do |t|
      t.integer :contest_id
      t.integer :student_id
      t.integer :cproblem_id
      t.integer :trials
      t.boolean :status

      t.timestamps
    end
    add_index :contest_progresses, [:contest_id, :student_id, :cproblem_id], :unique => true, :name => "ConProgress"
  end
end
