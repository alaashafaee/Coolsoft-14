class ProblemsController < ApplicationController



	def show 
		@problem = Problem.find_by_id(params[:id])

		if @problem.nil?
			render "problem_not_found"
		else
			@track = @problem.track
			@topic = @track.topic
			@course = @topic.course
		end
	end

end
