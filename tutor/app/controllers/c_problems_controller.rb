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
		@cproblem = Cproblem.new(cproblem_params)
		if lecturer_signed_in?
			@cproblem.owner_id = current_lecturer.id
			@cproblem.owner_type = "lecturer"
		elsif teaching_assistant_signed_in?
			@cproblem.owner_id = current_teaching_assistant.id
			@cproblem.owner_type = "teaching assistant"
		end

		if @cproblem.title.length == 0
			flash.keep[:notice] = "The problem can not have a blank title."
		elsif @cproblem.description.length == 0
			flash.keep[:notice] = "The problem can not have a blank description."
		elsif (!@cproblem.time_limit.is_a? Numeric) || @cproblem.time_limit < 1
			flash.keep[:notice] = "The problem time limit must be a numeric value greater than zero."
		else
			@cproblem.save
			flash.keep[:notice] = "Your contest problem has been created."
		end
		
		render ('new')
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
			@cproblem = Cproblem.new
			render ('new')
		end
	end

	# [Add contest problem - Story 3.23]
	# Filters the parameters required to create a CProblem
	# Parameters: none
	# Returns: 
	#	Filtered parameters
	# Author: Rami Khalil
	def cproblem_params
		params.require(:cproblem).permit(:title, :description, :time_limit)
	end
end
