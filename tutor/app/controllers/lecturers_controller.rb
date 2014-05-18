class LecturersController < ApplicationController
	# [Profile - Story 5.8]
	# Displays the profile of the lecturer chosen
	# Parameters:
	#	id: the Lecturer's id
	# Returns: none
	# Author: Serag
	def show
		@lecturer = Lecturer.find(params[:id])
		@courses = @lecturer.courses.order("created_at desc")
	end

	# [Number Of Problem Answered Correctly- Story 2.1]
	# Select all problems which have success_attempts greater than zero and count the records
	# Parameters:
	# 	success: an intger value that shows how many times does the problem have to be answered correctly
	# Returns:
	# 	an integer value: number of problems answered correctly	
	# 	in case of failure: a message "No problem is answered correctly"
	# Author: Rana ElNagar
  	def showCorrectAnswers
  		@course = Course.find(params[:id])
  		@topics = Topic.where(course_id: @course.id).find(params[:id])
  		@tracks = Track.where(topic_id: @topics.id).find(params[:id])
  		@problems = Problem.where(track_id: @tracks.id).find(params[:id])
  		@solutions = Attempt.where(problem_id: @problems.id).count(:success == true)
  		if @solutions == 0
  			flash[:notice] = "No problem is answered correctly"
  			render "no_correct_answer"
  		else 
  			render "show_statistics"
  		end
 	end

end
