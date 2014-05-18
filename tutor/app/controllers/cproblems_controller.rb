class CproblemsController < ApplicationController

  	# [Solve Contest Problem - Story 5.20]
	# View the selected problem from the contest
	# Parameters:
	# 	none
	# Returns:
	# 	@contest: the current opened contest
	# 	@problem: the curretn opened problem
	# Author: Ahmed Akram
	def show
		@contest = Contest.find_by_id(params[:id])
		@problem = Cproblem.find_by_id(params[:id])
		if @problem.nil?
			render "problem_not_found"
		end
	end

	# [Solve Contest Problem - Story 5.20]
	# Passes the information to the model to be inserted into the ContestProgress table
	# Parameters:
	# 	none
	# Returns:
	# 	none
	# Author: Ahmed Akram
	def submit
		contest_id = get_params[:contest_id]
		student_id = current_student.id
		cproblem_id = get_params[:cproblem_id]
		status = get_params[:status]
		Cproblem.submit(contest_id, cproblem_id, student_id, status)
		render json: {}
	end

	def create
	end

	def new
	end

	def index
	end

	# [Solve Contest Problem - Story 5.20]
	# Permits the selected attributes
	# Parameters:
	# 	none
	# Returns:
	# 	a hash consisting of the required parameters
	# Author: Ahmed Akram
	private
	def get_params
		params.permit(:contest_id, :cproblem_id, :status)
	end

	def get_contest_id
		params.permit(:contest_id, :cproblem_id)
	end

end