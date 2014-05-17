ActiveAdmin.register Lecturer do

	menu parent: "Users",priority:1
	permit_params   :email, :password, :password_confirmation, :dob, :gender, :degree,
				:university, :department, :name
	# [Admin - Story 3.19]
	# creates a form for creating Lecturer
	# Parameters: none.
	# Returns: none.  
	# Author: Mimi 
	form do |f|
		f.inputs "Lecturer Details" do
			f.input :name
			f.input :email
			f.input :password
			f.input :password_confirmation
			f.input :degree
			f.input :university
			f.input :department
			f.input :dob
			f.input :gender
		end
		f.actions
	end
end
