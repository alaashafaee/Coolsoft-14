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

	# [Contest Standings - Story 5.25]
	# Sorts students in contest according to the number of correct problems
	# they solved and the total time of submission
	# Parameters: none
	# Returns: sorted Hash containing ContestProgress of students
	def get_contest_standings
		contest_standing_records = ContestProgress.where(contest_id: self.id)
		contest_standings_unique = Hash.new
		contest_standing_records.each do |record|
			solved_problems = ContestProgress.where(contest_id: self.id, student_id: record.student.id,
			 status: false).count
			time_spent = 0
			ContestProgress.where(contest_id: self.id, student_id: record.student.id).each do |progress|
				updated_at = ContestProgress.where(contest_id: self.id , cproblem_id: progress.cproblem_id, student_id: record.student.id).take.updated_at
				start_time = Contest.find(self.id).start_time
				time_spent = time_spent + ((updated_at - start_time)/60).to_i
			end
			contest_standings_unique[record.student_id] = {solved: solved_problems, record: record, time_spent: time_spent} 
 		end
 		return Hash[contest_standings_unique.sort_by {|key, value| [value[:solved], value[:time_spent]]}.to_a]
	end


end
