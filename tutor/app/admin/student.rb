ActiveAdmin.register Student do

	menu parent: "Users", priority: 3
	permit_params	:name, :email, :password, :password_confirmation, :faculty, :semester,
				:major, :university, :dob, :gender
	# [Admin - Story 3.19]
	# creates a form for creating Student
	# Parameters: none.
	# Returns: none.  
	# Author: Mimi
	form do |f|
		f.inputs "Student Details" do
			f.input :name
			f.input :email
			f.input :password
			f.input :password_confirmation
			f.input :faculty
			f.input :semester
			f.input :major
			f.input :university
			f.input :dob
			f.input :gender
		end
		f.actions
	end
end