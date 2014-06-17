class CreateHints < ActiveRecord::Migration
  def change
	create_table :hints do |t|
	  t.text :message
	  t.boolean :category
	  t.integer :time
	  t.integer :submission_counter
	  t.integer :model_answer_id
	  
      t.references :owner, polymorphic: true
	  t.timestamps
	end
  end
end
