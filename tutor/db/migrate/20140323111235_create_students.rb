class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :faculty
      t.string :major
      t.integer :year
      t.integer :semester
      t.boolean :advising
      t.boolean :probation
      t.integer :failure_attempts
      t.integer :success_attempts

      t.timestamps
    end
  end
end
