ActiveAdmin.register DiscussionBoard do

	menu parent: "DBs/Posts", priority:1
	permit_params	:title, :activated, :course_id, :created_at, :updated_at
end
