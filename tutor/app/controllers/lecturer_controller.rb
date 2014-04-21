class LecturerController < ApplicationController
	# [number_of_problems_answered_correctly - Story 2.1]
	# Select all problems which have success_attempts greater than zero and count the records
	# Parameters =
	# 	success_attempts=an intger value that shows how many times does the problem have to be answered correctly
	# Returns: an integer value 
	# Returns in case of failure : a message "No problem is answered correctly"
	# Author: Rana ElNagar
  	def showCorrectAnswers
  		@problems = Problem.count(:success_attempts).where.not(:success_attempts == 0)
  		if @problems.nil?
  			flash[:notice] = "No problem is answered correctly"
  			render "no problem is answered correctly"
  		else 
  			render "show"
  		end
 	end

 	# [average number of trials - Story 2.3]
	# Select a problem_id and count the number of students who tried to answer this problem
	# Parameters =
	# 	success_attempts=an intger value that shows the number of correct answers by students
	# 	failure_attempts=an intger value that shows the number of wrong answers by students
	# 	student_id=a unique value for every student who try to answer a problem
	# 	problem_id=a unique value for every problem
	# Returns: an integer value 
	# Returns in case of failure : a message "No one answered this problem "
	# Author: Rana ElNagar
 	def average
 		@problem=Problem.find_by_id(params[:id])
 		if Solution.find_by problem_id = @problem?
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
 			render "show"
 		end
 	end


 	# [average time - Story 2.2]
	# Select a problem_id and calculate the average time taken to answer a problem
	# Parameters =
	# 	student_id=a unique value for every student who try to answer a problem
	# 	problem_id=a unique value for every problem
	# 	time=an intger value to show the time taken to write a specific solution
	# Returns: an integer value 
	# Returns in case of failure : a message "No one answered this problem "
	# Author: Rana ElNagar
 	def time
 		@problem=Problem.find_by_id(params[:id])
 		if Solution.find_by problem_id = @problem?
 			@time = Solution.find_by time 
 			unless @time.nil?
 				@time = @time + Solution.find_by time
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
 			render "show"
 		end
 	end

end
