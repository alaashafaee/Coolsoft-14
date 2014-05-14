class ContestsController < ApplicationController
	def add_problems
		if student_signed_in?
			render ('public/404')
		end
		#add support to add problems from create view not only edit view
		@contest = Contest.find(params[:id])
		if lecturer_signed_in? 
			if !current_lecturer.contests.include?(@contest)
				render ('public/404')
			else
				@owner = current_lecturer
			end
		elsif teaching_assistant_signed_in?
			if !current_teaching_assistant.contests.include?(@contest)
				render ('public/404')
			else 
				@owner = current_teaching_assistant
			end
		end
		@problems = Cproblem.all
	end

	def add
		@contest = Contest.find(params[:id])
		@problem = Cproblem.find(params[:problem_id])
		if @contest.problems.find_by_id(@problem.id).nil?
			@contest.problems << @problem
		end
		redirect_to :back
	end

end
