class CreateStuffCourses < ActiveRecord::Migration
  def change
    create_table :stuff_courses do |t|
      t.integer :course_id
      t.integer :stuff_id
      t.boolean :owner, default: false

      t.timestamps
    end
    add_index :stuff_courses, [:course_id,:stuff_id], :unique => true
  end

end
