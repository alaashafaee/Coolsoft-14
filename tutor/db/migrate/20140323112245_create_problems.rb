class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :title
      t.text :description
      t.integer :success_attempts
      t.integer :failure_attempts
      t.integer :views_count
      t.integer :time_limit
      t.integer :track_id

      
      t.references :owner, polymorphic: true

      t.timestamps
    end
  end
end
