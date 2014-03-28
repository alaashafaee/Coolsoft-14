class CreateDiscussionBoards < ActiveRecord::Migration
  	def change
	    create_table :discussion_boards do |t|
	      t.string :title
	      t.boolean :activated, default: true
	      t.integer :course_id
	      t.timestamps
    end
  end
end
