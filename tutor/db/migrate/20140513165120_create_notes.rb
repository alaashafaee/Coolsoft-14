class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :content
      t.integer :line
      t.integer :solution_id

      t.references :owner, polymorphic: true
      t.timestamps
    end
  end
end
