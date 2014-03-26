class CreateLecturers < ActiveRecord::Migration
  def change
    create_table :lecturers do |t|
      t.string :degree
      t.string :department

      t.timestamps
    end
  end
end
