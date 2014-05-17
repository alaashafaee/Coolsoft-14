ActiveAdmin.register Assignment do

	menu parent: "Assignment", priority:1
	permit_params	:title, :description, :final_grade, :assignment_id, :owner_id,
				:owner_type, :created_at, :updated_at
end
