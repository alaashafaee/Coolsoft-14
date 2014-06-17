class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :title
      t.text :description
      t.date :due_date
      t.boolean :publish

      t.integer :course_id
      t.references :owner, polymorphic: true
      t.timestamps
    end
    add_index :assignments, [:title, :course_id], :unique => true
  end
end
