ActiveAdmin.register TeachingAssistant do

	menu parent: "Users",priority:2
	permit_params	:email, :password, :password_confirmation, :dob, :gender, :degree, :graduated_year,
				:graduated_from, :university, :department, :name          
	# [Admin - Story 3.19]
	# creates a form for creating teaching_assistant
	# Parameters: none.
	# Returns: none.  
	# Author: Mimi
	form do |f|
		f.inputs "Teacher Assistant Details" do
			f.input :name
			f.input :email
			f.input :password
			f.input :password_confirmation
			f.input :degree
			f.input :university
			f.input :department
			f.input :dob
			f.input :gender
			f.input :graduated_from
			f.input :graduated_year
		end
		f.actions
	end
end