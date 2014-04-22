class Student < ActiveRecord::Base
	devise :database_authenticatable, :registerable,
			:recoverable, :rememberable, :trackable, 
			:validatable, :confirmable

	mount_uploader :profile_image, ProfileImageUploader

	#Validations
	validate :duplicate_email
	validates :name, presence: true
	validates_format_of :name, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z|\A\z/
	validates :university, presence: true
	validates_format_of :university, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z|\A\z/
	validates :faculty, presence: true
	validates_format_of :faculty, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z|\A\z/
	validates :major, presence: true
	validates_format_of :major, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z|\A\z/
	validates :semester, presence: false, numericality: {only_integer: true, greater_than: 0, less_than: 11}
	validates :dob, presence: true

	#Relations
	has_many :solutions, dependent: :destroy
	has_many :attempts, dependent: :destroy
	has_many :progressions, class_name: "TrackProgression"
	has_many :posts, as: :owner, dependent: :destroy
	has_many :replies, as: :owner, dependent: :destroy
	has_many :acknowledgements, dependent: :destroy

	has_many :recommendations
	has_many :recommended_problems, class_name: 'Problem', through: :recommendations, source: :problem
	
	has_and_belongs_to_many :courses, join_table: 'courses_students'

	#Methods

	# [User Authentication Advanced - Story 5.9, 5.10, 5.11, 5.14, 5.15]
	# Checks if the email is already registered in tables: Lecturer and TeachingAssistant
	# 	before registering the email for table: Student
	# Parameters: None
	# Returns: None
	# Author: Khaled Helmy
	def duplicate_email
		if Lecturer.find_by email: email or TeachingAssistant.find_by email: email
			errors.add(:email, "has already been taken")
		end
	end

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
end

