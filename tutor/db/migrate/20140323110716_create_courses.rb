class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :code
      t.integer :year
      t.integer :semester
      t.string :university
      t.text :description
      t.boolean :visible, default: false
      t.boolean :incomplete, default: true
      t.string :link

      t.timestamps
    end
  end
end
