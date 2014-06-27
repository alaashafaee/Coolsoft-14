class CreateCproblems < ActiveRecord::Migration
  def change
    create_table :cproblems do |t|
      t.string :title, unique: true
      t.text :description
      t.integer :time_limit
      t.boolean :incomplete, default: true
      
      t.references :owner, polymorphic: true
      t.timestamps
    end
  end
end
