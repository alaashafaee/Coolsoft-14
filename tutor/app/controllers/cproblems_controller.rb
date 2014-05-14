class CproblemsController < ApplicationController
  
	def show
		@contest = Contest.find_by_id(1)
		@problem = Cproblem.find_by_id(params[:id])
		if @problem.nil?
			render "problem_not_found"
		end
	end

	def submit
		contest_id = params[:contest_id]
		student_id = current_student.id
		cproblem_id = params[:problem_id]
		if params[:status].to_i == 1
			status = 1
		else
			status = 0
		end
		cp = ContestProgress.create(contest_id: contest_id, student_id: student_id,
									cproblem_id: cproblem_id, status: status)
		cp.save
		render json: {}
	end

	def create
	end

	def new
	end

	def index
	end

	private
	def param
		params.permit(:contest_id, :probelm_id)
	end

end