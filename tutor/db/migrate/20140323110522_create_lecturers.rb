class CreateLecturers < ActiveRecord::Migration
  def change
    create_table :lecturers do |t|
      t.string :name
      t.boolean :verified_type
      t.date :dob
      t.integer :age
      t.string :profile_image
      t.boolean :gender
      t.string :degree
      t.string :department

      t.timestamps
    end
  end
end
