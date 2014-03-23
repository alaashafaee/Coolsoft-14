class CreateVariableConstraints < ActiveRecord::Migration
  def change
    create_table :variable_constraints do |t|
      t.string :variable_name
      t.string :type

      t.timestamps
    end
  end
end
