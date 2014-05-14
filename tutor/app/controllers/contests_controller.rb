class ContestsController < ApplicationController
	
	# [Add Contest Problem - Story 5.18]
	# Passes instance variable of the contest to the add
	# 	problems view and renders the add problems view
	# Parameters: none
	# Returns: none
	# Author: Amir George
	def add_problems
		if student_signed_in?
			render ('public/404')
		end
		#add support to add problems from create view not only edit view
		@contest = Contest.find(params[:id])
		if lecturer_signed_in?  &&
			!current_lecturer.contests.include?(@contest)
			render ('public/404')
		elsif teaching_assistant_signed_in? &&
			!current_teaching_assistant.contests.include?(@contest)
			render ('public/404')
		end
		@problems = Cproblem.all
	end

	# [Add Contest Problem - Story 5.18]
	# Adds a certain problem to the contest if it was not
	# 	added before
	# Parameters: none
	# Returns: none
	# Author: Amir George
	def add
		@contest = Contest.find(params[:id])
		@problem = Cproblem.find(params[:problem_id])
		if @contest.problems.find_by_id(@problem.id).nil?
			@contest.problems << @problem
		end
		redirect_to :back
	end

end
