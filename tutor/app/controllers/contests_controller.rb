class ContestsController < ApplicationController

	# [Create Contest - Story 5.16]
	# Defines a new Contest instance for the form in the new view
	# Parameters: none
	# Returns: none
	# Author: Amir George
	def new
		if student_signed_in?
			render ('public/404')
		end
		if(@new_contest == nil)
			@new_contest = Contest.new
		end
		#if lecturer_signed_in?
		#	@owner_courses = current_lecturer.courses
		#	@owner_courses = @owner_courses.map {|x| x.name}
		#elsif teaching_assistant_signed_in?
		#	@owner_courses = current_teaching_assistant.courses
		#	@owner_courses = @owner_courses.map {|x| x.name}
		#end
	end

	# [Create Contest - Story 5.16]
	# Takes the params submitted from new form and inserts record
	# 	in database accordingly
	# Parameters: none
	# Returns: none
	# Author: Amir George
	def create
		if student_signed_in?
			render ('public/404')
		end
		@new_contest  = Contest.new
		@new_contest.title = contest_params[:title]
		unless contest_params[:course] == ""
			@new_contest.course = Course.find_by_name(contest_params[:course])
		end
		@new_contest.description = contest_params[:description]
		@new_contest.start_time = DateTime.new(contest_params["start_time(1i)"].to_i,
			contest_params["start_time(2i)"].to_i, contest_params["start_time(3i)"].to_i,
			contest_params["start_time(4i)"].to_i, contest_params["start_time(5i)"].to_i)
		@new_contest.end_time = DateTime.new(contest_params["end_time(1i)"].to_i,
			contest_params["end_time(2i)"].to_i, contest_params["end_time(3i)"].to_i,
			contest_params["end_time(4i)"].to_i, contest_params["end_time(5i)"].to_i)
		if lecturer_signed_in?
			@new_contest.owner = current_lecturer
		elsif teaching_assistant_signed_in?
			@new_contest.owner = current_teaching_assistant
		end
			
		if @new_contest.save
			flash[:success_creation]= "Contest added."
			redirect_to :action => 'index'
		else
			render :action=>'new'
		end
	end

	# [Create Contest - Story 5.16]
	# Defines contest parameters to be permitted from the form view
	# Parameters: none
	# Returns: none
	# Author: Amir George
	private
		def contest_params 
			params.require(:contest).permit(:title, :description, :course, :start_date, :start_time,
				:end_date, :end_time)
		end

end
