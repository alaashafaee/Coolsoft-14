ActiveAdmin.register CourseStudent do

	menu parent: "Subject", priority:6 
	permit_params	:share, :course_id, :student_id, :created_at, :updated_at
end
