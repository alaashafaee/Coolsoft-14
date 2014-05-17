class CProblemsController < ApplicationController

	# [Add contest problem - Story 3.23]
	# Creates a new contest problem to be inserted in the problem table
	# Parameters:
	#	title: The designated problem title
	#	description: The problem's description
	#	time_limit: A specified time limit for the problem
	# Returns: none
	# Author: Rami Khalil
	def create
		cproblem = Problem.new(cproblem_params)
		if lecturer_signed_in?
			cproblem.owner_id = current_lecturer.id
			cproblem.owner_type = "lecturer"
		elsif teaching_assistant_signed_in?
			cproblem.owner_id = current_teaching_assistant.id
			cproblem.owner_type = "teaching assistant"
		end

		if Problem.title.length == 0
			flash.keep[:notice] = "The problem can not have a blank title."
			redirect_to :back
		elsif Problem.description.length == 0
			flash.keep[:notice] = "The problem can not have a blank description."
			redirect_to :back
		elsif Problem.time_limit.length == 0
			flash.keep[:notice] = "The problem can not have a blank time limit."
			redirect_to :back
		else
			Problem.save
		end
	end

	# [Add contest problem - Story 3.23]
	# Shows the form for the contest problem
	# Parameters: none
	# Returns: none
	# Author: Rami Khalil
	def new
		if !lecturer_signed_in? && !teaching_assistant_signed_in?
			render ('public/404')
		else
			render ('new')
		end
	end

	# [Add contest problem - Story 3.23]
	# Filters the parameters required to create a CProblem
	# Parameters: none
	# Returns: Filtered parameters
	# Author: Rami Khalil
	def cproblem_params
		params.require(:CProblem).permit(:title, :description, :time_limit)
	end
end
