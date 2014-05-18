ActiveAdmin.register Reply do

	menu parent: "DBs/Posts",priority:3  
	permit_params	:content, :img, :post_id, :owner_id, :owner_type, :created_at, :updated_at
end
