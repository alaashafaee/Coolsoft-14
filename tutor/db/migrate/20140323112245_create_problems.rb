class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :title
      t.text :description
      t.text :snippet
      t.integer :views_count, default: 0
      t.integer :time_limit, default: 0
      t.integer :track_id
      t.boolean :fill_gaps, default: false
      t.boolean :incomplete, default: true
      t.boolean :seen, default: false
      t.boolean :duplicated, default: false

      t.references :owner, polymorphic: true
      t.timestamps
    end
    add_index :problems, [:track_id, :title], unique: true
  end
end
