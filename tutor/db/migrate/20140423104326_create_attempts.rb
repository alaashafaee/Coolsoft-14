class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
    	t.integer  :student_id
	    t.integer  :problem_id
	    t.boolean  :failure,    default: false
	    t.boolean  :success,    default: false
	    t.boolean  :incomplete, default: false
      
      t.timestamps
    end
  end
end
