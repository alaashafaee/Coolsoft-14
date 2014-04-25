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

	# [number_of_problems_answered_correctly - Story 2.1]
	# Select all problems which have success_attempts greater than zero and count the records
	# Parameters:
	# 	success_attempts:an intger value that shows how many times does the problem have to be answered correctly
	# Returns: an integer value 	in case of failure : a message "No problem is answered correctly"
	# Author: Rana ElNagar
  	def showCorrectAnswers
  		@solutions = Problem.count(:success_attempts).where.not(:success_attempts == 0)
  		if @problems.nil?
  			flash[:notice] = "No problem is answered correctly"
  			render "no_correct_answer"
  		else 
  			render "show_statistics"
  		end
 	end

 	# [average number of trials - Story 2.3]
	# Select a problem_id and count the number of students who tried to answer this problem
	# Parameters:
	# 	success_attempts:an intger value that shows the number of correct answers by students
	# 	failure_attempts:an intger value that shows the number of wrong answers by students
	# 	student_id:a unique value for every student who try to answer a problem
	# 	problem_id:a unique value for every problem
	# Returns: an integer value		in case of failure : a message "No one answered this problem "
	# Author: Rana ElNagar
 	def average
 		@problem=Problem.find_by_id(params[:id])
 		#if there is no solution it will not enter if condition !!! 
 		if Solution.find_by problem_id == @problem?
 			@students=Solution.distinct.count.(:student_id)
 		else 
 			redirect_to "average"
 		end
 		@number=Problem.count(:success_attempts)+Problem.count(:failure_attempts)
 		@average=(@number / @students) * 100
 		if @average.nil?
 			flash[:notice]= "no one answered this problem"
 			render "has_no_answer"
 		else
 			render "show_statistics"
 		end
 	end


 	# [average time - Story 2.2]
	# Select a problem_id and calculate the average time taken to answer a problem
	# Parameters :
	# 	student_id:a unique value for every student who try to answer a problem
	# 	problem_id:a unique value for every problem
	# 	time:an intger value to show the time taken to write a specific solution
	# Returns: an integer value 	in case of failure : a message "No one answered this problem "
	# Author: Rana ElNagar
 	def time
 		@problem=Problem.find_by_id(params[:id])
 		if Solution.find_by problem_id == @problem?
 			@time = Solution.select("time") 
 			unless @time.nil?
 				@time = @time + Solution.select("time")
 			end
 			@students=Solution.distinct.count.(:student_id)
 		else 
 			redirect_to "time"
 		end
 		@averageTime=(@time / @students)*100
 		if @averageTime.nil?
 			flash[:notice]="no one answered this problem"
 			render "has_no_answer"
 		else
 			render "show_statistics"
 		end
 	end

 	# [show attempts- Story 2.4]
	# Select a problem_id and select the attempts to answer this problem
	# Parameters :
	# 	problem_id:a unique value for every problem
	# 	code:a text to show the solution of a problem
	# Returns: text 	in case of failure : a message "No one answered this problem "
	# Author: Rana ElNagar
 	def showAttempts
 		@problem=Problem.find_by_id(params[:id])
 		@solution=Solution.find_by problem_id 
 		if @problem == @solution?
 			@attempt=Solution.select("code")
 			if @attempt.nil?
 				flash[:notice]="no one answered this problem"
 				render "has_no_answer"
 			else 
 				render "show_statistics"
 			end
 		else 
 			redirect_to "showAttempts"
 		end
 	end
end


