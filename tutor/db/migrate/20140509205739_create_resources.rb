class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.text :description
      t.string :link
      t.string :link_type
      t.string :img
      t.integer :course_id

      t.references :owner, polymorphic: true
      t.timestamps
    end
  end
end
