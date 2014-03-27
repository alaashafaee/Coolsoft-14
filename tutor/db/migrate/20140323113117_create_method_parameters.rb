class CreateMethodParameters < ActiveRecord::Migration
  def change
    create_table :method_parameters do |t|
      t.string :parameter
      t.integer :model_answer_id

      
      t.references :owner, polymorphic: true

      t.timestamps
    end
  end
end
