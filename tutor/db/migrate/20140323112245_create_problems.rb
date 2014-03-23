class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :title
      t.text :description
      t.integer :success_attpemts
      t.integer :failure_attempts
      t.integer :views_count

      t.timestamps
    end
  end
end
