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
	def validate_end_date_before_start_date
		if end_date < start_date
			errors.add(:end_date, "can't be before start date")
		elsif end_date == start_date && end_time <= start_time
			errors.add(:end_time, "must be after start time")
		end
	end

	def duplicate_title
		if Contest.find_by title: title
			errors.add(:title, "has already been taken")
		end
	end

end
