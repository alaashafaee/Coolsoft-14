class Student < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable

	#Validations

	#Relations
	has_many :solutions, dependent: :destroy
	has_many :attempts, dependent: :destroy
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

	# [Integrating_Akram_Device - Story 4.1]
	# Gets all the problem that this student attempted and puts each
	# state of attempt in a list : success , failure , other
	# Parameters: None
	# Returns: A hash with 3 list of the succeeded , failed problems
	# 	and the third in case there is another state yet to be known
	# Author: Mussab ElDash
	def getProblemsStatus
		res = {:success => [] , :failure => [] , :other => []}
		res[:success] = []
		res[:failure] = []
		res[:other] = []
		solutions = self.solutions
		solutions.each do |s|
			if s.status == 0
				res[:success] << s.problem
			elsif s.status == 1
				res[:failure] << s.problem
			else
				res[:other] << s.problem
			end
		end
		return res
	end

	def getClassMatesRecommendations
		recommended_problems = Recommendation.where(:student_id => self.id)
		recommended_problems_hash = Hash.new
		recommended_problems.each do |problem|
			recommended_problems_hash[problem.problem_id] = Hash.new
			recommender_name = Student.where(:id => problem.recommender_id).take.name
			problem_title = Problem.where(:id => problem.problem_id).take.title
			recommended_problems_hash[problem.problem_id]['recommender_name'] = recommender_name
			recommended_problems_hash[problem.problem_id]['problem_title'] = problem_title
		end
		return recommended_problems_hash
	end
end

