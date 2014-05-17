class CProblemsController < ApplicationController

	def index
		@c_problems = CProblem.all 
	end

	def destroy
		c_problem = CProblem.find_by_id(params[:id]).destroy
	end
end
