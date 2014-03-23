class CreateMethodParameters < ActiveRecord::Migration
  def change
    create_table :method_parameters do |t|
      t.string :parameter

      t.timestamps
    end
  end
end
