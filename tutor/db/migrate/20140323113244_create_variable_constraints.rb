class CreateVariableConstraints < ActiveRecord::Migration
  def change
    create_table :variable_constraints do |t|
      t.string :variable_name
      t.string :type
      t.integer :model_answer_id
      t.integer :stuff_id

      t.timestamps
    end
  end
end
