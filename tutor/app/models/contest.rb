class Contest < ActiveRecord::Base

	#Validations
	validates :title, presence: true
	validate :duplicate_title
	validates :course_id, presence: true
	validate :validate_end_date_before_start_date

	#Relations
	belongs_to :owner, polymorphic: true
	belongs_to :course

	has_many :progress, class_name: 'ContestProgress'
	has_and_belongs_to_many :students, class_name:"Student", join_table: "contests_students"
	has_and_belongs_to_many :problems, class_name:"Cproblem", join_table: "contests_cproblems"

	#Scoops

	#Methods

	# [Create Contest - Story 5.16]
	# Validates that the contest end date/time is after its
	# 	start date/time
	# Parameters: none
	# Returns: none
	# Author: Amir George
	def validate_end_date_before_start_date
		if end_date < start_date
			errors.add(:end_date, "can't be before start date")
		elsif end_date == start_date && end_time <= start_time
			errors.add(:end_time, "must be after start time")
		end
	end

	# [Create Contest - Story 5.16]
	# Validates that no contest with the same title exists
	# Parameters: none
	# Returns: none
	# Author: Amir George
	def duplicate_title
		if Contest.find_by title: title
			errors.add(:title, "has already been taken")
		end
	end

end
