class DebugController < ApplicationController

	# [Debugger: Debug - Story 3.6]
	# Send the recieved code to be debugged 
	# 	and return the result to the user as an json object
	# Parameters: 
	# 	id: The id of the problem being solved
	# 	code: The code to be debugged
	# 	case: Test case to be debugged against
	# Returns: Json object with the result of the debugging
	# Author: Mussab ElDash
	def start
		if lecturer_signed_in? || teaching_assistant_signed_in?
			render json: {}
		end
		id = current_student.id
		pid = params[:id]
		input = params[:code]
		cases = params[:case]
		result = Debugger.debug(id, pid, input, cases)
		p result
		render json: result
	end
end
