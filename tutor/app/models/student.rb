class Student < User
	
	#Validations

	#Relations
	# has_many :student_courses
	# has_many :courses, through: :student_courses

	has_many :solutions, dependent: :destroy

	has_many :recommendations
	has_many :recommended_problems, class_name: 'Problem', through: :recommendations, source: :problem
	has_and_belongs_to_many :courses, join_table: 'courses_students'

	
	#Scoops

	#Methods
	def get_a_system_suggested_problem
		suggestions = Set.new

		courses.each do |course|
			course.topics.each do |topic|
				
#				level = TrackProgression.find_by(
#							user_id: self.id,
#							topic_id: topic.id
#						).level
				level = 0 #dummy value -- waiting for TrackProgression model

				topic.tracks.each do |track|
#						if(track.difficulty == level)
							track.problems.each do |problem|
								if(!problem.is_solved_by_user(self.id))
									print "GOT ONE!!!!"
									suggestions.add(problem)
									break
								end
							end
#						end
				end
			end
		end

		return suggestions.to_a().sample()
	end

end
