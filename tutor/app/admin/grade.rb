ActiveAdmin.register Grade do

	menu parent: "Assignment", priority:2
	permit_params	:problem_id, :student_id, :grade, :editor_id, :editor_type, :created_at, :updated_at
end
