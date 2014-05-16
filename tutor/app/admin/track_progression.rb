ActiveAdmin.register TrackProgression do

	menu parent: "Subject", priority:5
	permit_params	:level, :student_id, :topic_id, :created_at, :updated_at
end
