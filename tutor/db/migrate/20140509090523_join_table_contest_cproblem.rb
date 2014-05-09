class JoinTableContestCproblem < ActiveRecord::Migration
  def change
    create_join_table :contests, :cproblems do |t|
      # t.index [:contest_id, :cproblem_id]
      # t.index [:cproblem_id, :contest_id]
    end
    add_index :contests_cproblems, [:contest_id, :cproblem_id], :unique => true
  end
end
