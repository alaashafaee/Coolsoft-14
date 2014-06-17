class CreateModelAnswers < ActiveRecord::Migration
  def change
    create_table :model_answers do |t|
      t.string :title
      t.text :answer
      t.integer :problem_id
      
      t.references :owner, polymorphic: true
      t.timestamps
    end
  end
end
