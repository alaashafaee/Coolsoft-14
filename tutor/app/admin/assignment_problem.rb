ActiveAdmin.register AssignmentProblem do

	menu parent: "Problems", priority:2
	permit_params	:title, :description, :time_limit, :owner_id, :owner_type, :created_at,
				:updated_at, :assignment_id, :final_grade
end
