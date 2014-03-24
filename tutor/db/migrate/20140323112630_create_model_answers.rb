class CreateModelAnswers < ActiveRecord::Migration
  def change
    create_table :model_answers do |t|
      t.text :answer
      t.integer :problem_id
      t.integer :stuff_id

      t.timestamps
    end
  end
end
