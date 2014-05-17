ActiveAdmin.register Course do

	menu parent: "Subject", priority:1
	permit_params	:name, :code, :year, :semester, :university, :description, :visible, :incomplete,
				:link, :created_at, :updated_at
end
