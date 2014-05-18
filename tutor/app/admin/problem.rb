ActiveAdmin.register Problem do

	menu parent: "Problems", priority:1
	permit_params	:title, :description, :incomplete, :views_count, :time_limit, :track_id,
				:snippet, :fill_gaps, :public, :owner_id, :owner_type, :created_at, :updated_at
end
