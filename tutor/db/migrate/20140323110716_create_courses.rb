class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :code
      t.integer :year
      t.integer :semester
      t.text :description
      t.boolean :enable_discussion

      t.timestamps
    end
  end
end
