class StudentsController < ApplicationController

  def get_performance
  	@solved = Attempt.where(student_id:1, success:true).select("DISTINCT problem_id").count
  	@failed = Attempt.count(:conditions => { :failure => true, :student_id => current_student.id })
    @solved_list = Attempt.where(student_id:1, success:true).select("DISTINCT problem_id")    
  end

end
# Attempt.find(:all, 
#    	:conditions => { :success => true , :student_id => current_student.id })
#Attempt.count(:conditions => { :success => true, :student_id => current_student.id })
# render(:action => 'solved_problems')