ActiveAdmin.register TestCase do

	menu parent: "Problems", priority:5
	permit_params	:input, :output, :model_answer_id, :problem_id, :owner_id, :owner_type,
				:created_at, :updated_at
end
