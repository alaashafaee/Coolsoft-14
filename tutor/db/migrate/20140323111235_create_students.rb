class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.date :dob
      t.string :profile_image
      t.boolean :gender
      t.string :university
      t.string :faculty
      t.string :major
      t.integer :semester
      t.boolean :advising, default: false
      t.boolean :probation, default: false

      t.timestamps
    end
  end
end
