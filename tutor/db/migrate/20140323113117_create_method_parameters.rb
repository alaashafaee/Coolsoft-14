class CreateMethodParameters < ActiveRecord::Migration
  def change
    create_table :method_parameters do |t|
      t.string :parameter
      t.integer :model_answer_id
      t.integer :stuff_id

      t.timestamps
    end
  end
end
