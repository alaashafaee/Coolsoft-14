class CreateMethodConstraints < ActiveRecord::Migration
  def change
    create_table :method_constraints do |t|
      t.string :method_name

      t.timestamps
    end
  end
end
