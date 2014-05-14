class ContestsController < ApplicationController

	# [Edit Contest - Story 5.17]
	# Passes instance variable of the contest to be edited to the edit
	# 	view and renders the edit view
	# Parameters: none
	# Returns: none
	# Author: Amir George
	def edit
		if student_signed_in?
			render ('public/404')
		end
		@contest = Contest.find(params[:id])
		if lecturer_signed_in? &&
			!current_lecturer.contests.include?(@contest)
			render ('public/404')
		elsif teaching_assistant_signed_in? &&
			!current_teaching_assistant.contests.include?(@contest)
			render ('public/404')
		end
	end

	# [Edit Contest - Story 5.17]
	# Takes the updated values from the view form and updates record
	# 	in database accordingly
	# Parameters: none
	# Returns: none
	# Author: Amir George
	def update
		@contest  = Contest.find(params[:id])
		@contest.course = Course.find_by_name(course_param[:course])
		if @contest.update_attributes(contest_params)
			redirect_to(:action => 'show', :id => @contest.id)
		else
			render :action=>'edit'
		end
	end

	# [Edit Contest - Story 5.17]
	# Gets the course id, removes it from the database and then
	# 	redirects the user to the show contests page
	# Parameters: none
	# Returns: none
	# Author: Amir George
	def destroy
		if student_signed_in?
			render ('public/404')
		end
		contest = Contest.find(params[:id])
		if lecturer_signed_in? &&
			!current_lecturer.contests.include?(contest)
			render ('public/404')
		elsif teaching_assistant_signed_in? &&
			!current_teaching_assistant.contests.include?(contest)
			render ('public/404')
		else
		contest.destroy
		flash[:success_deletion] = "Contest deleted."
		redirect_to :action => 'index'
		end
	end

	# [Edit Contest - Story 5.17]
	# Defines the parameters for the contest to be permitted from the
	# 	form view
	# Parameters: none
	# Returns: none
	# Author: Amir George
	private
		def contest_params 
			params.require(:contest).permit(:title, :description, :start_time,
				:end_time)
		end

	# [Edit Contest - Story 5.17]
	# Permits the course parameter from the view to be handled separately
	# 	in the update action
	# Parameters: none
	# Returns: none
	# Author: Amir George
	private
		def course_param
			params.require(:contest).permit(:course)
		end

end
