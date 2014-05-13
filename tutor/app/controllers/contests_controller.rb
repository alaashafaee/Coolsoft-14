class ContestsController < ApplicationController



	def create
	end

	# Author: Ahmed Akram
	def solve
		@student_id = current_student.id
		@problem = Cproblem.first
		@contest = Contest.find_by_id(1)

		code = params[:code]
		student = current_student.id
		problem = 1
		time = 20
		result = SolutionsLayer.validate "java", code, student, problem, time, "Contest"
		render json: result
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