class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.text :code
      t.integer :length
      t.integer :status
      t.integer :student_id
      t.integer :problem_id

      t.timestamps
    end
  end
end
