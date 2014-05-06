class JoinTableContestProblem < ActiveRecord::Migration
  def change
  	create_join_table :contests, :problems do |t|
      # t.index [:contest_id, :problem_id]
      # t.index [:problem_id, :contest_id]
  	end
  	add_index(:contests_problems, [:contest_id, :problem_id], :unique => true)
  end
end
