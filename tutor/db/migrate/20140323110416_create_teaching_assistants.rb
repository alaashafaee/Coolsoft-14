class CreateTeachingAssistants < ActiveRecord::Migration
  def change
    create_table :teaching_assistants do |t|
      t.string :graduated_from
      t.integer :graduated_year
      t.boolean :type
      t.string :department

      t.timestamps
    end
  end
end
