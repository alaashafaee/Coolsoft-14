class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :title
      t.text :description
      t.boolean :incomplete
      t.time :start_time
      t.time :end_time
      t.date :start_date
      t.date :end_date

      t.integer :course_id
      t.references :owner, polymorphic: true
      t.timestamps
    end
  end
end
