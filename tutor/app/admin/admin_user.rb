ActiveAdmin.register AdminUser do

	menu parent: "Users", priority: 4
	permit_params :email, :password, :password_confirmation
	
	# [Admin - Story 3.19]
	# creates table to show the attributes of the admins.
	# Parameters: none.
	# Returns: none.  
	# Author: Mimi
	index do
		selectable_column
		id_column
		column :email
		column :current_sign_in_at
		column :sign_in_count
		column :created_at
		actions
	end

	# [Admin - Story 3.19]
	# It is used to filter the results by the specified attributes.
	# Parameters: none.
	# Returns: none.  
	# Author: Mimi
	filter :email
	filter :current_sign_in_at
	filter :sign_in_count
	filter :created_at

	# [Admin - Story 3.19]
	# creates a form for creating Admin
	# Parameters: none.
	# Returns: none.  
	# Author: Mimi
	form do |f|
		f.inputs "Admin Details" do
			f.input :email
			f.input :password
			f.input :password_confirmation
		end
		f.actions
	end
	
end