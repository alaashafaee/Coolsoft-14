class Contest < ActiveRecord::Base

	#Validations
	validates :title, presence: true
	validate :duplicate_title, :on => :create
	validate :validate_start_date_before_end_date
	validate :validate_future_start_time

	#Relations
	belongs_to :owner, polymorphic: true
	belongs_to :course

	has_many :progress, class_name: 'ContestProgress'
	has_and_belongs_to_many :students, class_name:"Student", join_table: "contests_students"
	has_and_belongs_to_many :problems, class_name:"Cproblem", join_table: "contests_cproblems"

	#Scoops

	#Methods

	# [Contest Standings - Story 5.25]
	# Sorts students in contest according to the number of correct problems
	# 	they solved and the total time of submission
	# Parameters: none
	# Returns: Sorted Hash containing ContestProgress of students
	# Author: Mohab Ghanim
	def get_contest_standings
		contest_standing_records = ContestProgress.where(contest_id: self.id)
		contest_standings_unique = Hash.new
		contest_standing_records.each do |record|
			wrong_answers = ContestProgress.where(contest_id: self.id,
				student_id: record.student.id,
				status: false).count
			time_spent = 0
			ContestProgress.where(contest_id: self.id,
				student_id: record.student.id).each do |progress|
				updated_at = ContestProgress.where(contest_id: self.id, cproblem_id:
					progress.cproblem_id, student_id: record.student.id).take.updated_at
				start_time = Contest.find(self.id).start_time
				time_spent = time_spent + ((updated_at - start_time)/60).to_i
			end
			contest_standings_unique[record.student_id] = {wrong_answers: wrong_answers,
				record: record, time_spent: time_spent}
		end
		return Hash[contest_standings_unique.sort_by {|key, value| [value[:wrong_answers],
			value[:time_spent]]}.to_a]
	end

	# [Create Contest - Story 5.16]
	# Validates that the contest end date/time is after its
	# 	start date/time
	# Parameters: none
	# Returns: none
	# Author: Amir George
	def validate_start_date_before_end_date
		if end_time <= start_time
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

	# [Create Contest - Story 5.16]
	# Validates that contest's start time must be in the future
	# Parameters: none
	# Returns: none
	# Author: Amir George
	def validate_future_start_time
		if start_time <= Time.now
			errors.add(:start_time, "must be in the future")
		end
	end

end