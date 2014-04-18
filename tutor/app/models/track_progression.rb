class TrackProgression < ActiveRecord::Base
	
	#Validations

	#Relations
	belongs_to :student
	belongs_to :topic
	
	#Scoops

	#Methods
	# [Find Recommendations - Story 3.9]
	# Returns the target users progress level in the target topic
	# If the progression record does not exist, returns level 0 by default
	# Parameters: 
	#	user_id: The target user's ID
	# 	topic_id: The target topic's ID
	# Returns: The target user's progress level in the target opic as an integer
	# Author: Rami Khalil
	def self.get_progress(student_id, topic_id)
		progression = find_by(student_id: student_id, topic_id: topic_id)
		
		if(progression == nil)
			if(Student.find(student_id) != nil && Topic.find(topic_id) != nil)
				create(student_id: student_id, topic_id: topic_id, level: 0)
			end
		else
			return progression.level
		end

		return 0
	end
end
