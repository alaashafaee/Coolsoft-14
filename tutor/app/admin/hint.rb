ActiveAdmin.register Hint do

	menu parent: "Problems", priority:4
	permit_params	:message, :category, :time, :submission_counter, :model_answer_id,
				:owner_id, :owner_type, :created_at, :updated_at
end
