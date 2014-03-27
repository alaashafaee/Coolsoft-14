class CreateTeachingAssistants < ActiveRecord::Migration
  def change
    create_table :teaching_assistants do |t|
      t.string :name
      t.string :email
      t.boolean :verified_type
      t.string :password
      t.date :dob
      t.integer :age
      t.string :profile_image
      t.boolean :gender
      t.string :graduated_from
      t.integer :graduated_year
      t.boolean :type
      t.string :department

      t.timestamps
    end
  end
end
