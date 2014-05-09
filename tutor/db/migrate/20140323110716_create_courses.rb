class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :code
      t.integer :year
      t.integer :semester
      t.string :university
      t.text :description
      t.boolean :visible
      t.boolean :incomplete

      t.timestamps
    end
  end
end
