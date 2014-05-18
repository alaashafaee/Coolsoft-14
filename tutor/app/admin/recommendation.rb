ActiveAdmin.register Recommendation do

	menu parent: "Problems", priority:7
	permit_params :problem_id, :student_id, :recommender_id
	# [Admin - Story 3.19]
	# creates a form for creating "Recommendation"
	# Parameters: none.
	# Returns: none.  
	# Author: Mimi
	form do |f|
		f.inputs "Recommendation Details" do
			f.input :problem_id
			f.input :student_id
			f.input :recommender_id
		end
		f.actions
	end
end
