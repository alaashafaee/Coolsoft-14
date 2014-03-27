class TrackProgression < ActiveRecord::Base


	#Validations

	#Relations
	belongs_to :user
	belongs_to :topic
	
	#Scoops

	#Methods

	# [Class Method]
	# Returns the target users progress level in the target topic
	# If the progression record does not exist, returns level 0 by default
	# Parameters: 
	#	user_id => The target user's ID
	# 	topic_id => The target topic's ID
	# Returns: An integer
	def self.get_progress(user_id, topic_id)
		# Try to fetch the progression record for the user, topic pair
		progression = find_by(user_id: user_id, topic_id: topic_id)
		
		# If no record exists
		if(progression == nil)
			# If both the target user and target topic exist
			if(User.find(user_id) != nil && Topic.find(topic_id) != nil)
				# Create a new progression record for this pair with initial value 0
				create(user_id: user_id, topic_id: topic_id, level: 0)
			end
		else
			# If the record exists, return the stored progression level
			return progression.level
		end

		# No record exists, return 0 by default
		return 0
	end
end
