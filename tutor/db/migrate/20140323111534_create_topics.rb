class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.text :description
      t.integer :order_factor
      t.integer :course_id
      t.integer :lecturer_id

      t.timestamps
    end
  end
end
