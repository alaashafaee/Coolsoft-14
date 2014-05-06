class JoinTableContestStudent < ActiveRecord::Migration
  def change
    create_join_table :contests, :students do |t|
      # t.index [:contest_id, :student_id]
      # t.index [:student_id, :contest_id]
    end
    add_index(:contests_students, [:contest_id, :student_id], :unique => true)
  end
end
