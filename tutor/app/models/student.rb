class Student < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
			:recoverable, :rememberable, :trackable, :validatable
	
	#Validations

	#Relations
	# has_many :student_courses
	# has_many :courses, through: :student_courses
	has_one :user, as: :sub

	has_many :solutions, dependent: :destroy

	has_many :progressions, class_name: "TrackProgression"

	has_many :posts, dependent: :destroy
	has_many :replies, dependent: :destroy

	has_many :recommendations
	has_many :recommended_problems, class_name: 'Problem', through: :recommendations, source: :problem
	
	has_and_belongs_to_many :courses, join_table: 'courses_students'
	
	#Scoops

	#Methods

	# [Instance method]
	# Returns a suggested problem to solve for this user
	# Parameters: None
	# Returns: A Problem model instance
	# Author: Rami Khalil
	def get_a_system_suggested_problem
		# Create a new empty set
		suggestions = Set.new

		# For every course this student is enrolled in
		courses.each do |course|
			# For every topic this course contains
			course.topics.each do |topic|
				# Get this student's progress level for this course
				level = TrackProgression.get_progress(self.id, topic.id)

				# For every track in this course topic
				topic.tracks.each do |track|
						# If this track's difficulty matches the student's progress level
						if(track.difficulty == level)
							# Check every problem in this track
							track.problems.each do |problem|
								# If this problem has not been solved by this student before
								if(!problem.is_solved_by_student(self.id))
									# Add the problem to the suggestions set
									suggestions.add(problem)
									# Only take one problem per track
									# Break out of problem loop
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
end
