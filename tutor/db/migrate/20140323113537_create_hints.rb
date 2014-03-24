class CreateHints < ActiveRecord::Migration
  def change
	create_table :hints do |t|
	  t.text :message
	  t.boolean :type
	  t.integer :time
	  t.integer :submission_counter
	  t.integer :model_answer_id
	  t.integer :stuff_id

	  t.timestamps
	end
  end
end
