ActiveAdmin.register Post do

	menu parent: "DBs/Posts",priority:2
	permit_params	:title, :img, :content, :views_count, :discussion_board_id, :owner_id,
				:owner_type, :created_at, :updated_at
end
