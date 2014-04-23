class CreateTeachingAssistants < ActiveRecord::Migration
  def change
    create_table :teaching_assistants do |t|
      t.string :name
      t.date :dob
      t.string :profile_image
      t.boolean :gender
      t.string :graduated_from
      t.integer :graduated_year
      t.string :department
      t.string :university
      t.string :degree

      t.timestamps
    end
  end
end
