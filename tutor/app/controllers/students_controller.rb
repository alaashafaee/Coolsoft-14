class StudentsController < ApplicationController

	# [Performance of a student - Story 5.3]
	# This method retrieve variables from tables in the database
	# Parameters:
	# 	params: A hash of the request URL attributes
	# 	success, failure, incomplete: Booleans represent the status of the problem
	# Returns:
	# 	@solved: [int] The number of solved problems
	# 	@failed: [int] The number of failed problems
	# 	@incomplete: [int] The number of incomplete problems
	# Author: Mahdi
	def get_performance
		@solved = Attempt.where(student_id:params[:student_id], success:true).joins(problem: {track: :topic}).where('topics.course_id' => params[:course_id]).select("DISTINCT problem_id").count
		@failed = Attempt.where(student_id:params[:student_id], failure:true).joins(problem: {track: :topic}).where('topics.course_id' => params[:course_id]).select("DISTINCT problem_id").count
		@incomplete = Attempt.where(student_id:params[:student_id], incomplete:true).joins(problem: {track: :topic}).where('topics.course_id' => params[:course_id]).select("DISTINCT problem_id").count
		#Recheck here for the missing DB
		#@solved_contest = Attempt.where(student_id:params[:student_id], success:true).joins(contest_problem: {track: :topic}).where('topics.course_id' => params[:course_id]).select("DISTINCT problem_id").count
		#@failed_contest = Attempt.where(student_id:params[:student_id], failure:true).joins(contest_problem: {track: :topic}).where('topics.course_id' => params[:course_id]).select("DISTINCT problem_id").count
	end

	def list_courses
		@courses_list = CourseStudent.where(student_id: current_student.id)
	end
	# [Performance of a student - Story 5.3]
	# This method retrieve variables from tables in the database
	# Parameters:
	# 	params: A hash of the request URL attributes
	# Returns:
	# 	An array of solved problems
	# Author: Mahdi
	def solved_problems
		@solved_list = Attempt.where(student_id:params[:student_id], success:true).joins(problem: {track: :topic}).where('topics.course_id' => params[:course_id]).select("DISTINCT problem_id")
	end

	# [Performance of a student - Story 5.3]
	# This method retrieve variables from tables in the database 
	# Parameters:
	# 	params: A hash of the request URL attributes
	# Returns:
	# 	An array of failed problems
	# Author: Mahdi
	def failed_problems
		@failure_list = Attempt.where(student_id:params[:student_id], failure:true).joins(problem: {track: :topic}).where('topics.course_id' => params[:course_id]).select("DISTINCT problem_id")
	end

	# [Performance of a student - Story 5.3]
	# This method retrieve variables from tables in the database
	# Parameters:
	# 	params: A hash of the request URL attributes
	# Returns:
	# 	An array of incomplete problems  
	# Author: Mahdi  
	def incomplete_problems
		@failure_list = Attempt.where(student_id:params[:student_id], icnomplete:true).joins(problem: {track: :topic}).where('topics.course_id' => params[:course_id]).select("DISTINCT problem_id")
	end

	def view_registrants
		@contest_registrants = Contest.find_by_id(2).students
	end

	# [Profile - Story 5.8]
	# Displays the profile of the student chosen
	# Parameters:
	#	id: the Student's id
	# Returns: none
	# Author: Serag
	def show
		@student = Student.find(params[:id])
		@courses = @student.courses.order("created_at desc")
	end
	
end
