class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :problem_id
      t.integer :student_id
      t.integer :recommender_id, null: false

      t.timestamps
    end
    add_index :recommendations, [:problem_id,:student_id,:recommender_id], :unique => true, :name => 'recom_problems'
  end
end
