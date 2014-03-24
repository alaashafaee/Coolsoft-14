class CreateRecommendProblems < ActiveRecord::Migration
  def change
    create_table :recommend_problems do |t|
      t.integer :problem_id
      t.integer :student_id
      t.integer :recommender_id

      t.timestamps
    end
    add_index :recommend_problems, [:problem_id,:student_id], :unique => true, :name => 'recom_problems'
  end
end
