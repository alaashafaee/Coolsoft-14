ActiveAdmin.register ContestProgress do

	menu parent: "Contest", priority:2
	permit_params	:contest_id, :student_id, :cproblem_id, :status, :created_at, :updated_at
end
