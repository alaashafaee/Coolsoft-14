class CreateAcknowledgements < ActiveRecord::Migration
  def change
    create_table :acknowledgements do |t|
      t.string :message
      t.integer :course_id
      t.integer :student_id
      t.integer :lecturer_id

      t.timestamps
    end
  end
end
