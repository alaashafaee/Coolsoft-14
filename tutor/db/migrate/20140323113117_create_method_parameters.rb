class CreateMethodParameters < ActiveRecord::Migration
  def change
    create_table :method_parameters do |t|
      t.string :parameter
      t.string :params_type
      t.integer :method_constraint_id
      
      t.references :owner, polymorphic: true
      t.timestamps
    end
  end
end
