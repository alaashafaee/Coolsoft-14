class ContestsController < ApplicationController



	def create
	end

	# Author: Ahmed Akram
	def solve
		@student_id = current_student.id
		@problem = Cproblem.first
		@contest = Contest.find_by_id(1)
		if @contest.students.find_by_id(@student_id)
			@var = "hahahah"
		else
			redirect_to :back
		end
	end


	private
	def contest_params
		params.permit(:id, :student_id)
	end

end