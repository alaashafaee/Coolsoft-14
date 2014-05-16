ActiveAdmin.register Attempt do

	menu parent:"Problems", priority:6
	permit_params	:student_id, :problem_id, :failure, :success, :incomplete, :created_at
				:updated_at
end
