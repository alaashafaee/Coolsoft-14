class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.text :code
      t.integer :length
      t.boolean :status
      t.integer :student_id

      t.timestamps
    end
  end
end
