class AssignmentProblemsController < ApplicationController
	def show
		@problem = AssignmentProblem.find_by_id(params[:id])
		if @problem.nil?
			render "problem_not_found"
		else
			#@track = @problem.track
			#@topic = @track.topic
			#@course = @topic.course
			@assignment = @problem.assignment
			@course = @assignment.course
			puts(@course)
			puts(@assignment)
		end
	end
end
