class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :title
      t.text :description
      t.boolean :incomplete
      t.integer :views_count
      t.integer :time_limit
      t.integer :track_id
      t.string :problem_type

      t.references :owner, polymorphic: true
      t.timestamps
    end
    add_index :problems, [:track_id, :title], unique: true
  end
end
