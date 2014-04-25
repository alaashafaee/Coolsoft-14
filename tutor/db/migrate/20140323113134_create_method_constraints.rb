class CreateMethodConstraints < ActiveRecord::Migration
  def change
    create_table :method_constraints do |t|
      t.string :method_name
      t.string :method_return
      t.integer :model_answer_id

      
      t.references :owner, polymorphic: true

      t.timestamps
    end
  end
end
