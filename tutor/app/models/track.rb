class Track < ActiveRecord::Base

	#Validations
	validates :difficulty, presence: true, inclusion: { in: (-1..4) }
	validates :difficulty, uniqueness: { scope: :topic_id,
		message: "A topic can not have two trcks with the same difficulty" },
		unless: "topic.nil? || difficulty == -1"
	validates :title , presence: true

	#Relations
	has_many :problems, dependent: :destroy

	belongs_to :topic	
	belongs_to :owner, polymorphic: true

	#Scoops

	#Methods

	# [Create Track - Story 4.1]
	# Get a text difficulty of this track
	# Parameters: none
	# Returns:
	# 	A string according to the current difficulty of this track
	# Author: Mussab ElDash
	def get_difficulty_name
		if difficulty == 0
			return "Very Easy"
		elsif difficulty == 1
			return "Easy"
		elsif difficulty == 2
			return "Medium"
		elsif difficulty == 3
			return "Hard"
		elsif difficulty == 4
			return "Very Hard"
		else
			return "Not Supported"
		end
	end

	# [Create Track - Story 4.1]
	# Get a text difficulty of the number given
	# Parameters:
	#	difficulty: The difficulty that be converted to string and by default its -1
	# Returns:
	# 	A string according to the number given
	# Author: Mussab ElDash
	def self.get_difficulty_name difficulty = -1
		if difficulty == 0
			return "Very Easy"
		elsif difficulty == 1
			return "Easy"
		elsif difficulty == 2
			return "Medium"
		elsif difficulty == 3
			return "Hard"
		elsif difficulty == 4
			return "Very Hard"
		else
			return "Not Supported"
		end
	end

	def visible_for *users
		course = topic.course
		return true if course.can_edit *users
		users.each do |user|
			return false if user.is_a?(Student) && 
				TrackProgression.get_progress(user.id, topic.id) < difficulty
			problems.each do |p|
				unless p.incomplete
					return true
				end
			end
		end
		return false
	end

	def problems_for *users
		course = topic.course
		return problems if course.can_edit *users
		st_problems = []
		problems.each do |pr|
			unless pr.incomplete
				st_problems << pr
			end
		end
		return st_problems
	end
end
