class CreateMethodConstraints < ActiveRecord::Migration
  def change
    create_table :method_constraints do |t|
      t.string :method_name
      t.integer :model_answer_id
      t.integer :staff_id

      t.timestamps
    end
  end
end
