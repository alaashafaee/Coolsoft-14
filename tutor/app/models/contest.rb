class Contest < ActiveRecord::Base

	#Validations

	#Relations
	belongs_to :owner, polymorphic: true
	belongs_to :course

	has_many :progress, class_name: 'ContestProgress'
	has_and_belongs_to_many :students, class_name:"Student", join_table: "contests_students"
	has_and_belongs_to_many :problems, class_name:"Cproblem", join_table: "contests_cproblems"

	#Scoops

	#Methods
	def get_contest_standings
		contest_standing_records = ContestProgress.where(contest_id: self.id)
		contest_standings_unique = Hash.new
		contest_standing_records.each do |record|
			contest_standings_unique[record.student_id] = record
 		end
 		return contest_standings_unique
	end

end
