class CreateModelAnswers < ActiveRecord::Migration
  def change
    create_table :model_answers do |t|
      t.text :answer

      t.timestamps
    end
  end
end
