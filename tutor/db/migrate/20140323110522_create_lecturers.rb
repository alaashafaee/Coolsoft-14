class CreateLecturers < ActiveRecord::Migration
  def change
    create_table :lecturers do |t|
      t.string :name
      t.date :dob
      t.string :profile_image
      t.boolean :gender
      t.string :degree
      t.string :department
      t.string :university

      t.timestamps
    end
  end
end
