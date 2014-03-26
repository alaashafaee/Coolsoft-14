class TrackProgression < ActiveRecord::Base


	#Validations

	#Relations
	belongs_to :user
	belongs_to :topic
	
	#Scoops

	#Methods
	def self.get_progress(user_id, topic_id)
		progression = find_by(user_id: user_id, topic_id: topic_id)
		
		if(progression == nil)
			if(User.find(user_id) != nil && Topic.find(topic_id) != nil)
				create(user_id: user_id, topic_id: topic_id, level: 0)
			end
		else
			return progression.level
		end

		return 0
	end
end
