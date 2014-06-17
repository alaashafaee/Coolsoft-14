class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :title
      t.text :description
      t.boolean :incomplete
      t.datetime :start_time
      t.datetime :end_time

      t.integer :course_id
      t.references :owner, polymorphic: true
      t.timestamps
    end
  end
end
