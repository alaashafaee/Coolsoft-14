class Student < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable

	#Validations

	#Relations
	has_many :solutions, dependent: :destroy
	has_many :progressions, class_name: "TrackProgression"
	has_many :posts, as: :owner, dependent: :destroy
	has_many :replies, as: :owner, dependent: :destroy

	has_many :recommendations
	has_many :recommended_problems, class_name: 'Problem', through: :recommendations, source: :problem
	
	has_and_belongs_to_many :courses, join_table: 'courses_students'
	
	#Scoops

	#Methods
	# [Find Recommendations - Story 3.9]
	# Returns a suggested problem to solve for this user
	# Parameters: None
	# Returns: A Problem model instance for the suggested problem
	# Author: Rami Khalil
	def get_a_system_suggested_problem
		suggestions = Set.new

		courses.each do |course|
			course.topics.each do |topic|
				level = TrackProgression.get_progress(self.id, topic.id)

				topic.tracks.each do |track|
						if(track.difficulty == level)
							track.problems.each do |problem|
								if(!problem.is_solved_by_student(self.id))
									suggestions.add(problem)
									break
								end
							end
						end
				end
			end
		end

		# Convert suggestions from set to array
		# Return random element from array
		return suggestions.to_a().sample()
	end

	def get_next_problems_to_solve
		next_problems_to_solve = Hash.new

		courses.each do |course|
			course.topics.each do |topic|
				level = TrackProgression.get_progress(self.id, topic.id)

				topic.tracks.each do |track|
						if(track.difficulty == level)
							track.problems.each do |problem|
								if(!problem.is_solved_by_student(self.id))
									key = course.name
									key += " - " + topic.title
									key += " - " + track.title
									next_problems_to_solve[key] = problem
									break
								end
							end
						end
				end
			end
		end

		return next_problems_to_solve
	end


end

