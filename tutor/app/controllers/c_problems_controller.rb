class CProblemsController < ApplicationController

	#for test
	def index
		@c_problems = Cproblem.all 
	end

	#for test
	def show
		@c_problem = Cproblem.find_by_id(params[:id])
	end

	# [Remove Contest Problem - Story 5.29]
	# Delete the current contest problem 
	# Parameters:
	# 	params[:id]: The current contest problem id
	# Returns:
	# 	none
	# Author: Rania Abdel Fattah
	def destroy
		if lecturer_signed_in?
			c_problem = Cproblem.find_by_id(params[:id]).destroy
			flash[:error] = "Contest Problem deleted."
			redirect_to :action => 'index'
		end
	end
end