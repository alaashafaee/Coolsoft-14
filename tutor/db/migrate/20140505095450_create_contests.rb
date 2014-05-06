class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :title
      t.text :description
      t.datetime :expiration_date

      t.integer :course_id
      t.references :owner, polymorphic: true
      t.timestamps
    end
  end
end
