class Track < ActiveRecord::Base

	#Validations
	validates :difficulty, presence: true
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
end
