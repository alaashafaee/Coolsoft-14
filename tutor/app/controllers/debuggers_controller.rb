class DebuggersController < ApplicationController

	# [Debugger: Debug - Story 3.6]
	# Send the recieved code to be debugged
	# 	and return the result to the user as a json object
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
		code = params[:code]
		problem_type = params[:problem_type]
		cases = if params[:case] then params[:case] else "" end
		class_name = params[:class_name]
		lang = params[:lang]
		result = SolutionsLayer.debug lang, code, id, pid, problem_type, class_name, cases
		render json: result
	end

end