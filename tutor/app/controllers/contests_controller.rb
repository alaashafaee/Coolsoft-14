class ContestsController < ApplicationController

	before_action :validate_timer, only: [:standings, :show, :registrants]

	# [Contest Standings - Story 5.25]
	# Returns the contest object whose id is params[:id]
	# Parameters: none
	# Returns: none
	# Author: Mohab Ghanim
	def standings
		@contest = Contest.find_by_id(params[:id])
	end

	# [Contest Registration - Story 5.24]
	# Add the current student to the choosen contest
	# Parameters:
	# 	params[:id]: The current contest id
	# Returns: none
	# Author: Rania Abdel Fattah
	def register
		if student_signed_in?
			contest = Contest.find_by_id(params[:id])
			current_student.contests << contest
			redirect_to "/contests"
		end
	end

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

	# [View Contest Problems - Story 5.26]
	# Description: Displays the contest that the user chose
	# Parameters:
	#	@contest: The contest id that the user chose
	#	@problems = The list of problems of the contest
	# Returns: The view of the contest
	# Author: Ahmed Atef
	def show
		@contest = Contest.find(params[:id])
		@problems =  @contest.problems.all
	end

	# [View Contests - Stroy 5.19]
	# This action renders a list of all contests belonging to 
	#	the current user.
	# Parameters:
	#	current_lecturer: The current signed in lecturer
	#	current_teaching_assistant: The currrent signed in teaching assistant
	#	current_students: The current signed in student	
	# Returns: 
	#	@contest: A list of all the user's contests
	# Author: Muhammad Mamdouh
	def index
		if current_lecturer
			@contests = current_lecturer.contests
		elsif current_teaching_assistant
			@contests = current_teaching_assistant.contests
		elsif current_student
			@my_contests = current_student.contests
			@courses = current_student.courses
			@contests = []
			@courses.each do |course|
				course.contests.each do |contest|
					unless @my_contests.exists?(contest.id)
						@contests << contest
					end
				end
			end
		end
	end	

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
		if @contest.update_attributes(contest_params_update)
			redirect_to(:action => 'show', :id => @contest.id)
		else
			render :action=>'edit'
		end
	end

	# [Create Contest - Story 5.16]
	# Takes the params submitted from new form and inserts record
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
		@new_contest.start_time = DateTime.new(
			contest_params["start_time(1i)"].to_i,
			contest_params["start_time(2i)"].to_i,
			contest_params["start_time(3i)"].to_i,
			contest_params["start_time(4i)"].to_i,
			contest_params["start_time(5i)"].to_i)
		@new_contest.end_time = DateTime.new(
			contest_params["end_time(1i)"].to_i,
			contest_params["end_time(2i)"].to_i,
			contest_params["end_time(3i)"].to_i,
			contest_params["end_time(4i)"].to_i,
			contest_params["end_time(5i)"].to_i)
		if lecturer_signed_in?
			@new_contest.owner = current_lecturer
		elsif teaching_assistant_signed_in?
			@new_contest.owner = current_teaching_assistant
		end

		if @new_contest.save
			flash[:success_creation]= "Contest added."
			Notification.contests_notify(@new_contest.course_id,
				@new_contest.id)
			redirect_to :action => 'index'
		else
			render :action=>'new'
		end
	end

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
		@contest = Contest.find(params[:id])
		if lecturer_signed_in?  &&
			!current_lecturer.contests.include?(@contest)
			render ('public/404')
		elsif teaching_assistant_signed_in? &&
			!current_teaching_assistant.contests.include?(@contest)
			render ('public/404')
		end
		@problems = Cproblem.all
		courseContests = @contest.course.contests
		courseContests.each do |contest|
			@problems = @problems - contest.problems
		end
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
		flash[:added] = "Your Problem is now added"
		redirect_to :back
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

	def registrants
		@contest_registrants = Contest.find_by_id(params[:id]).students
	end

	# [Create Contest - Story 5.16]
	# Defines contest parameters to be permitted from the form view
	private
		def contest_params
			params.require(:contest).permit(:title, :description,
				:course, :start_time, :end_time)
		end

	# [Edit Contest - Story 5.17]
	# Defines the parameters for the contest to be permitted from the
	# 	form view
	private
		def contest_params_update 
			params.require(:contest).permit(:title, :description,
				:start_time, :end_time)
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

	# [Contest Timer - Story 5.28]
	# Checks the state of the timer based on the date and time of a specific contest
	# 	and affecting the behaviour of the timer and the message that accompanies it
	# 	based on the timing of the contest. If the contest didn't start yet, the timer
	# 	will be set to countdown till the start of the contest and the message appearing
	# 	will be 'Contest starts in'. If the contest has started, the timer will be set
	# 	to countdown till the end of the contest and the message will be 'Contest ends in'.
	# 	If the contest has ended, the timer will disappear and the message will be
	# 	'Contest has finished!'.
	# Parameters:
	# 	params[:id]: an Integer containing the id of a specific contest to have its timer.
	# Returns:
	# 	@timer: a String representation of a DateTime object representing the date
	# 		and the time of the contest that will be used by the timer.
	# 	@message: a String containing the message accompanying the timer.
	# 	@del: a Boolean indicating if the contest has finished which affects the
	# 		behaviour of the timer; whether to remove it or not.
	# Author: Khaled Helmy
	private
		def validate_timer
			@contest = Contest.find(params[:id])
			contest_start = @contest.start_time
			contest_end = @contest.end_time
			current = DateTime.now
			if current < contest_start
				@timer = contest_start
				@message = "Contest starts in"
				@del = false
			elsif current <= contest_end
				@timer = contest_end
				@message = "Contest ends in"
				@del = false
			else
				@timer = nil
				@message = "Contest has finished!"
				@del = true
			end
		end

end