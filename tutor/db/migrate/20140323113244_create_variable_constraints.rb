class CreateVariableConstraints < ActiveRecord::Migration
  def change
    create_table :variable_constraints do |t|
      t.string :variable_name
      t.string :variable_type
      t.integer :model_answer_id

      t.references :owner, polymorphic: true
      t.timestamps
    end
  end
end
