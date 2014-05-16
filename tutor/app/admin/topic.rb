ActiveAdmin.register Topic do

	menu parent: "Subject", priority:2
	permit_params	:title, :description, :order_factor, :course_id, :lecturer_id, :created_at,
				:updated_at
end
