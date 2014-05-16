ActiveAdmin.register Track do

	menu parent: "Subject", priority:3
	permit_params	:title, :difficulty, :views_count, :topic_id, :owner_id, :owner_type,
				:created_at, :updated_at
end
