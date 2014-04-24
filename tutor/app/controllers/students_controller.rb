class StudentsController < ApplicationController

#[Performance of a student - Story 5.3]
#These methods retrieve variables from tables in the database
#Parameters:
#params[]: A hash of the request URL attributes
#success, failure, incomplete: Booleans represent the status of the problem
#Returns:
#@solved, @failed, @incomplete: [int] The number of solved, failed and incomplete problems
#@solved_list, @failure_list, @incomplete_list: Arrays of solved,failed and incomplete problems
#Author : Mahdi
  def get_performance
  	@solved = Attempt.where(student_id:params[:id], success:true).select("DISTINCT problem_id").count
  	@failed = Attempt.where(student_id:params[:id], failure:true).select("DISTINCT problem_id").count
  	@incomplete = Attempt.where(student_id:params[:id], incomplete:true).select("DISTINCT problem_id").count        
  end

  def solved_problems
  	@solved_list = Attempt.where(student_id:params[:id], success:true).select("DISTINCT problem_id")
  end

  def failed_problems
  	@failure_list = Attempt.where(student_id:params[:id], failure:true).select("DISTINCT problem_id")
  end

  def incomplete_problems
  	@incomplete_list = Attempt.where(student_id:params[:id], incomplete:true).select("DISTINCT problem_id")
  end

end
