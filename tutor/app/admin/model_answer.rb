ActiveAdmin.register ModelAnswer do

	menu parent: "Problems", priority:8
	permit_params	:title, :answer, :problem_id, :owner_id, :owner_type
end