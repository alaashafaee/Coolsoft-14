ActiveAdmin.register Cproblem do

	menu parent: "Problems", priority:3
	permit_params	:title, :description, :time_limit, :owner_id, :owner_type, :created_at, :updated_at
end
