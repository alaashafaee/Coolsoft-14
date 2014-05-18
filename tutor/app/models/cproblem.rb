class Cproblem < ActiveRecord::Base

	#Validations

	#Relations
	belongs_to :owner, polymorphic: true

	has_many :test_cases, dependent: :destroy
	has_many :solutions, as: :problem
	has_many :contests_progresses, class_name: "ContestProgress"
	has_and_belongs_to_many :contests, join_table: "contests_cproblems"

	#Scoops

	#Methods
	# [Solve Contest Problem - Story 5.20]
	# Passes the information to the model to be inserted into the ContestProgress table
	# Parameters:
	# 	contest_id: the id of the contest
	# 	cproblem_id: the id of the problem being solved
	# 	student_id: the solver id
	# 	_status: the status of the solution
	# Returns:
	# 	none
	# Author: Ahmed Akram
	def self.submit(contest_id, cproblem_id, student_id, _status)
		contest_end_time = Contest.find_by_id(contest_id).end_time.to_time
		problem_submission_time = DateTime.now.to_time
		if _status.to_i == 1
			status = 1
		else
			status = 0
		end
		cp = ContestProgress.where(student_id: student_id, contest_id: contest_id, 
								cproblem_id: cproblem_id)[0]
		if !cp
			cp = ContestProgress.create(contest_id: contest_id, student_id: student_id,
										cproblem_id: cproblem_id, status: false, trials: 0)
			cp.save
		end
		if cp.status == false
			if(contest_end_time - problem_submission_time > 0)
				if status == 1
					cp.status = true
				end
				cp.trials = cp.trials + 1
				cp.save
			end
		end
	end

end