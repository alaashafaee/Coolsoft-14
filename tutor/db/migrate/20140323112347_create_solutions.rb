class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.text :code
      t.integer :length
      t.integer :status
      t.integer :time
      t.text :class_name
      t.integer :student_id
      
      t.references :problem, polymorphic: true
      t.timestamps
    end
  end
end
