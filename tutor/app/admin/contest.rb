ActiveAdmin.register Contest do

	menu parent: "Contest", priority:1
	permit_params	:title, :description, :incomplete, :start_time, :end_time,
				:course_id, :owner_type, :owner_id, :created_at, :updated_at
end
