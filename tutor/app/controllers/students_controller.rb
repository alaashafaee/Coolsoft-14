class StudentsController < ApplicationController
#Story 5.3 [Performance of a student]
#These methods retrieve variables from tables in the database
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
